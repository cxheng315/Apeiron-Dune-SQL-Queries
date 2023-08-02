select
    mint_type,
    count(*) as mint_count
from (
    select
        case when (bytearray_to_int256(substr(data, 66, 32)) = cast('0'as int256)) then 'Paid Mint' else 'Free Mint' end as mint_type
    from polygon.logs
    where 
        contract_address = 0xF786195B491141C350316d388CaFC8bF8cbe65f7
        and topic0 = 0x49e568b69969025a65554f19edbbfdf9de110df1b65c52f4d14df5908356042d
)
group by mint_type
