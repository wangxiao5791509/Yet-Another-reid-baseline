#-------------------1. train model on source domain-----------------------------
python ./tools/train.py --config_file='configs/visda20.yml' \
MODEL.DEVICE_ID "('4')" \
MODEL.BACKBONE "resnet50_ibn_a" \
MODEL.PRETRAIN_PATH '/home/zxy/.cache/torch/checkpoints/r50_ibn_a.pth' \
DATASETS.ROOT_DIR '/home/zxy/data/ReID/visda' \
DATASETS.TRAIN "('personx',)" \
SOLVER.MAX_EPOCHS 25 \
INPUT.RE_PROB 0.0 \
INPUT.AUGMIX_PROB 0.0 \
INPUT.AUTOAUG_PROB 0.0 \
INPUT.COLORJIT_PROB 0.0 \
OUTPUT_DIR './output/visda20_reproduce/0_ablation_no_dataaug'


#--------------------train-------------------------------------------------------
python ./tools/train.py --config_file='configs/visda20.yml' \
MODEL.DEVICE_ID "('3')" \
MODEL.BACKBONE "resnet101_ibn_a" \
MODEL.PRETRAIN_PATH '/home/zxy/.cache/torch/checkpoints/r101_ibn_a.pth' \
DATASETS.ROOT_DIR '/home/zxy/data/ReID/visda' \
DATASETS.TRAIN "('personx', 'visda20_pseudo',)" \
OUTPUT_DIR './output/visda20/0724-ensemble/r101'


python ./tools/train.py --config_file='configs/visda20.yml' \
MODEL.DEVICE_ID "('3')" \
MODEL.BACKBONE "resnet101_ibn_a" \
MODEL.PRETRAIN_PATH '/home/zxy/.cache/torch/checkpoints/r101_ibn_a.pth' \
DATASETS.ROOT_DIR '/home/zxy/data/ReID/visda' \
DATASETS.TRAIN "('personx', 'visda20_pseudo',)" \
MODEL.METRIC_LOSS_TYPE 'circle' \
OUTPUT_DIR './output/visda20/0724-ensemble/r101-circle'


python ./tools/train.py --config_file='configs/visda20.yml' \
MODEL.DEVICE_ID "('4')" \
MODEL.BACKBONE "('resnest50')" \
MODEL.PRETRAIN_PATH "('/home/zxy/.cache/torch/checkpoints/resnest50-528c19ca.pth')" \
DATASETS.ROOT_DIR '/home/zxy/data/ReID/visda' \
DATASETS.TRAIN "('personx', 'visda20_pseudo',)" \
OUTPUT_DIR './output/visda20/0724-ensemble/nest50'


python ./tools/train.py --config_file='configs/visda20.yml' \
MODEL.DEVICE_ID "('5')" \
MODEL.BACKBONE "('se_resnet101_ibn_a')" \
MODEL.PRETRAIN_PATH "('/home/zxy/.cache/torch/checkpoints/se_r101_ibn_a.pth')" \
DATASETS.ROOT_DIR '/home/zxy/data/ReID/visda' \
DATASETS.TRAIN "('personx', 'visda20_pseudo',)" \
OUTPUT_DIR './output/visda20/0723-ensemble/senet'



python ./tools/train.py --config_file='configs/visda20.yml' \
MODEL.DEVICE_ID "('4')" \
MODEL.BACKBONE "('resnext101_ibn_a')" \
MODEL.PRETRAIN_PATH "('/home/zxy/.cache/torch/checkpoints/resnext101_ibn_a.pth')" \
DATASETS.ROOT_DIR '/home/zxy/data/ReID/visda' \
DATASETS.TRAIN "('personx', 'visda20_pseudo',)" \
OUTPUT_DIR './output/visda20/0723-ensemble/next'


python ./tools/train.py --config_file='configs/visda20.yml' \
MODEL.DEVICE_ID "('3')" \
MODEL.BACKBONE "('resnet34_ibn_a')" \
MODEL.PRETRAIN_PATH "('/home/zxy/.cache/torch/checkpoints/r34_ibn_a.pth')" \
DATASETS.ROOT_DIR '/home/zxy/data/ReID/visda' \
DATASETS.TRAIN "('personx', 'visda20_pseudo',)" \
OUTPUT_DIR './output/visda20/0723-ensemble/r34'


#-------------------- finetune---------------------------------------------------
python ./tools/train.py --config_file='configs/visda20.yml' \
MODEL.DEVICE_ID "('4')" \
MODEL.BACKBONE "resnet50_ibn_a" \
MODEL.PRETRAIN_CHOICE 'finetune' \
MODEL.PRETRAIN_PATH './output/visda20/0724-ensemble/r50/best.pth' \
DATASETS.ROOT_DIR '/home/zxy/data/ReID/visda' \
SOLVER.MAX_EPOCHS  10 \
SOLVER.FREEZE_EPOCHS 0 \
SOLVER.BASE_LR 1e-4 \
SOLVER.EVAL_PERIOD 1 \
OUTPUT_DIR './output/visda20/0724-ensemble/r50/fintune-test'


python ./tools/train.py --config_file='configs/visda20.yml' \
MODEL.DEVICE_ID "('3')" \
MODEL.BACKBONE "resnet101_ibn_a" \
MODEL.PRETRAIN_CHOICE 'finetune' \
MODEL.PRETRAIN_PATH './output/visda20/0724-ensemble/r101/best.pth' \
DATASETS.ROOT_DIR '/home/zxy/data/ReID/visda' \
SOLVER.MAX_EPOCHS  10 \
SOLVER.FREEZE_EPOCHS 0 \
SOLVER.EVAL_PERIOD 1 \
OUTPUT_DIR './output/visda20/0724-ensemble/r101/finetune'



python ./tools/train.py --config_file='configs/visda20.yml' \
MODEL.DEVICE_ID "('2')" \
MODEL.BACKBONE "resnest50" \
MODEL.PRETRAIN_CHOICE 'finetune' \
MODEL.PRETRAIN_PATH './output/visda20/0724-ensemble/nest50/best.pth' \
DATASETS.ROOT_DIR '/home/zxy/data/ReID/visda' \
SOLVER.MAX_EPOCHS  10 \
SOLVER.FREEZE_EPOCHS 0 \
OUTPUT_DIR './output/visda20/0724-ensemble/nest50/finetune'


python ./tools/train.py --config_file='configs/visda20.yml' \
MODEL.DEVICE_ID "('3')" \
MODEL.BACKBONE "resnest101" \
MODEL.PRETRAIN_CHOICE 'finetune' \
MODEL.PRETRAIN_PATH './output/visda20/0723-ensemble/nest101/best.pth' \
DATASETS.ROOT_DIR '/home/zxy/data/ReID/visda' \
SOLVER.MAX_EPOCHS  10 \
SOLVER.FREEZE_EPOCHS 0 \
OUTPUT_DIR './output/visda20/0723-search/finetune-nest101'



python ./tools/train.py --config_file='configs/visda20.yml' \
MODEL.DEVICE_ID "('3')" \
MODEL.BACKBONE "se_resnet101_ibn_a" \
MODEL.PRETRAIN_CHOICE 'finetune' \
MODEL.PRETRAIN_PATH './output/visda20/0723-ensemble/senet/best.pth' \
DATASETS.ROOT_DIR '/home/zxy/data/ReID/visda' \
SOLVER.MAX_EPOCHS  10 \
SOLVER.FREEZE_EPOCHS 0 \
SOLVER.EVAL_PERIOD 1 \
OUTPUT_DIR './output/visda20/0723-search/finetune-senet'


python ./tools/train.py --config_file='configs/visda20.yml' \
MODEL.DEVICE_ID "('3')" \
MODEL.BACKBONE "densenet169_ibn_a" \
MODEL.PRETRAIN_CHOICE 'finetune' \
MODEL.PRETRAIN_PATH './output/visda20/0723-ensemble/d169/best.pth' \
DATASETS.ROOT_DIR '/home/zxy/data/ReID/visda' \
SOLVER.MAX_EPOCHS  10 \
SOLVER.FREEZE_EPOCHS 0 \
SOLVER.EVAL_PERIOD 1 \
OUTPUT_DIR './output/visda20/0723-search/finetune-d169'
#-------------------------- BN adaptive----------------------

python ./tools/train.py --config_file='configs/visda20.yml' \
MODEL.DEVICE_ID "('3')" \
MODEL.BACKBONE "resnet50_ibn_a" \
MODEL.PRETRAIN_CHOICE 'finetune' \
MODEL.PRETRAIN_PATH './output/visda20/0725-search/ori-personx/best.pth' \
DATASETS.ROOT_DIR '/home/zxy/data/ReID/visda' \
SOLVER.MAX_EPOCHS  30 \
SOLVER.FREEZE_EPOCHS 0 \
OUTPUT_DIR './output/visda20/0725-search/ori-personx/finetune'