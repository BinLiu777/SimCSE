#!/bin/bash

# In this example, we show how to train SimCSE on unsupervised Wikipedia data.
# If you want to train it with multiple GPU cards, see "run_sup_example.sh"
# about how to use PyTorch's distributed data parallel.

# model
# --model_name_or_path bert-base-uncased \
# --model_name_or_path bert-base-chinese \

# saller
# --train_file data/saller/asr_saller.txt \
# --output_dir result/unsup/saller_webank \

# wbank
# --train_file data/webank/webank_pure_text_nocut_train.txt \
# --output_dir result/unsup/webank_webank \

# wiki_en
# --train_file data/wiki1m_for_simcse.txt \
# --output_dir result/unsup/wiki1m \


NUM_GPU=1
PORT_ID=$(expr $RANDOM + 1000)

python -m torch.distributed.launch --nproc_per_node $NUM_GPU --master_port $PORT_ID train.py \
    --model_name_or_path bert-base-chinese \
    --train_file data/webank/webank_pure_text_nocut_train.txt \
    --output_dir result/unsup/webank_webank \
    --num_train_epochs 5 \
    --per_device_train_batch_size 64 \
    --learning_rate 5e-5 \
    --max_seq_length 32 \
    --metric_for_best_model webank_spearman \
    --load_best_model_at_end \
    --pooler_type cls \
    --mlp_only_train \
    --overwrite_output_dir \
    --temp 0.05 \
    --do_train \
    --eval_steps 250 \
    --evaluation_strategy steps \
    --do_eval \
    --fp16 \
    --local_rank 0 \
    "$@"

