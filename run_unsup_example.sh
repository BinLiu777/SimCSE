#!/bin/bash

# In this example, we show how to train SimCSE on unsupervised Wikipedia data.
# If you want to train it with multiple GPU cards, see "run_sup_example.sh"
# about how to use PyTorch's distributed data parallel.

# model
# --model_name_or_path bert-base-uncased \
# --model_name_or_path bert-base-chinese \

# data
  # train
    # saller
    # --train_file data/saller/asr_saller.txt \
    # --output_dir result/unsup/saller_webank \

    # wbank
    # --train_file data/webank/webank_pure_text_nocut_train.txt \
    # --output_dir result/unsup/webank_webank \

    # wiki_en
    # --train_file data/wiki1m_for_simcse.txt \
    # --output_dir result/unsup/wiki1m \
  # dev
    # --metric_for_best_model webank_spearman \
    # --metric_for_best_model stsb_spearman \


NUM_GPU=1
PORT_ID=$(expr $RANDOM + 1000)

python -m torch.distributed.launch --nproc_per_node $NUM_GPU --master_port $PORT_ID train.py \
    --model_name_or_path bert-base-chinese \
    --train_file data/saller_good_ppl.txt \
    --output_dir result/unsup/saller_saller \
    --num_train_epochs 3 \
    --per_device_train_batch_size 512 \
    --learning_rate 5e-5 \
    --max_seq_length 64 \
    --metric_for_best_model stsb_spearman \
    --load_best_model_at_end \
    --pooler_type cls_before_pooler \
    --mlp_only_train \
    --overwrite_output_dir \
    --temp 0.05 \
    --do_train \
    --eval_steps  \
    --evaluation_strategy steps \
    --do_eval \
    --fp16 \
    --local_rank 0 \
    "$@"

