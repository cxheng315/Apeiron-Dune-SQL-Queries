select 
    row_number() over ( order by count(to) desc ) as no,
    to as wallet_address,
    count(to) as breed_count
from erc721_polygon.evt_Transfer
where 
    evt_tx_hash in ( 
        select tx_hash 
        from polygon.logs 
        where topic0 = 0x41c74960920a5e4634136ef918c3dad391f28441f61638fdc8803397d2ba3d00 -- breed topic
    )

group by to
order by breed_count desc
