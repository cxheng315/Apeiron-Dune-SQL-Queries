select
  date_trunc('day', block_time) as date,
  count(tx_hash) as daily_breed_planet_count
from (
    select tx_hash, block_time from polygon.logs
    where topic0 = 0x41c74960920a5e4634136ef918c3dad391f28441f61638fdc8803397d2ba3d00 -- breed topic
)
group by 1
order by date
