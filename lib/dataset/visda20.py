import glob
import re

import os.path as osp

from .base import BaseImageDataset


class VisDA20(BaseImageDataset):
    """
    image_train: unlabeled dataset (but with camera ids)
    http://ai.bu.edu/visda-2020/
    """
    dataset_dir = 'target_training'

    def __init__(self, root='', verbose=True, **kwargs):
        super(VisDA20, self).__init__()
        self.dataset_dir = osp.join(root, self.dataset_dir)
        self.train_dir = osp.join(self.dataset_dir, 'image_train')
        self.query_dir = osp.join(self.dataset_dir, 'image_query')
        self.gallery_dir = osp.join(self.dataset_dir, 'image_gallery')

        self._check_before_run()

        train = self._load_in_order(self.train_dir, osp.join(self.dataset_dir, 'label_target_training.txt'),
                                    relabel=True)
        query = self._load_in_order_test(self.query_dir, osp.join(self.dataset_dir, 'index_test_query.txt'))
        gallery = self._load_in_order_test(self.gallery_dir, osp.join(self.dataset_dir, 'index_test_gallery.txt'))

        if verbose:
            print("=> visda loaded")

        self.train = train
        self.query = query
        self.gallery = gallery

        self.num_train_pids, self.num_train_imgs, self.num_train_cams = self.get_imagedata_info(self.train)
        self.num_query_pids, self.num_query_imgs, self.num_query_cams = self.get_imagedata_info(self.query)
        self.num_gallery_pids, self.num_gallery_imgs, self.num_gallery_cams = self.get_imagedata_info(self.gallery)

    def _check_before_run(self):
        """Check if all files are available before going deeper"""
        if not osp.exists(self.dataset_dir):
            raise RuntimeError("'{}' is not available".format(self.dataset_dir))
        if not osp.exists(self.train_dir):
            raise RuntimeError("'{}' is not available".format(self.train_dir))

    def _load_in_order(self, img_dir, txt_path, relabel=False):
        dataset = []
        with open(txt_path, 'r') as f:
            lines = f.readlines()
        for i, line in enumerate(lines):
            line = line.strip()
            img_name, camid = line.split(' ')
            img_path = osp.join(img_dir, img_name)
            camid = int(camid) - 1
            pid = i
            dataset.append([img_path, pid, camid])
            #dataset.append([img_path, camid, pid])
        if relabel: self.relabel(dataset)
        return dataset

    def _load_in_order_test(self, img_dir, txt_path):
        dataset = []
        with open(txt_path, 'r') as f:
            lines = f.readlines()
        for line in lines:
            line = line.strip()
            img_name, idx = line.split('  ')
            img_path = osp.join(img_dir, img_name)
            camid = 0
            pid = 0
            dataset.append([img_path, pid, camid])
            #dataset.append([img_path, camid, pid])
        return dataset
