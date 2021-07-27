python evaluation.py \
    --model_name_or_path result/my-unsup-simcse-bert-base-chinese-webank \
    --pooler cls_before_pooler \
    --task_set sts \
    --mode test
#    --model_name_or_path princeton-nlp/sup-simcse-bert-base-uncased \