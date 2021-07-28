#!/bin/bash

# In this example, we show how to train SimCSE on unsupervised Wikipedia data.
# If you want to train it with multiple GPU cards, see "run_sup_example.sh"
# about how to use PyTorch's distributed data parallel.
NUM_GPU=1
PORT_ID=$(expr $RANDOM + 1000)

CUDA_VISIBLE_DEVICES=1 python -m torch.distributed.launch --nproc_per_node $NUM_GPU --master_port $PORT_ID train.py \
    --model_name_or_path bert-base-chinese \
    --train_file data/saller/asr_saller.txt \
    --output_dir result/saller_totol_test \
    --num_train_epochs 5 \
    --per_device_train_batch_size 64 \
    --learning_rate 3e-5 \
    --max_seq_length 32 \
    --metric_for_best_model stsb_spearman \
    --load_best_model_at_end \
    --pooler_type cls \
    --mlp_only_train \
    --overwrite_output_dir \
    --temp 0.05 \
    --do_train \
    --eval_steps 125 \
    --evaluation_strategy steps \
    --do_eval \
    --fp16 \
    --local_rank 0 \
    "$@"

