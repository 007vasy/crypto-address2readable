SELECT Replace(topics[OFFSET(2)],'000000000000000000000000','') as owner_address,
REGEXP_REPLACE(
    SAFE_CONVERT_BYTES_TO_STRING(
        CAST(
            substr(data,195) as BYTES FORMAT 'HEX'
            ) 
        )
    ,"[^0-9A-Za-z_-]","") AS ens_name,

log_index,transaction_hash,address,block_timestamp,block_number,block_hash, topics[OFFSET(0)] as topic_0
FROM bigquery-public-data.crypto_ethereum.logs
WHERE DATE(block_timestamp) >= "2020-01-30"
and lower(address) = lower('0x283Af0B28c62C092C9727F1Ee09c02CA627EB7F5')
and array_length(topics) > 0
and CHAR_LENGTH(data) >= 195 + 32
and lower('0xca6abbe9d7f11422cb6ca7629fbf6fe9efb1c621f71ce8f02b9f2a230097404f') = topics[OFFSET(0)]
ORDER BY DATE(block_timestamp) DESC
LIMIT 100