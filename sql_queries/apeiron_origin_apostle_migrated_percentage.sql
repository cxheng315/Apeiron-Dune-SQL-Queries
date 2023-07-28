with 
apostle_migration as (
    select 
        erc1155_polygon.evt_TransferSingle.id,
        value
    from erc1155_polygon.evt_TransferSingle
    left join query_2336983 on query_2336983.id = erc1155_polygon.evt_TransferSingle.id
    where
        erc1155_polygon.evt_TransferSingle.contract_address = 0x2953399124f0cbb46d2cbacd8a89cf0599974963 -- OpenSea Apeiron Origin Apostle Mint Ticket
        and to = 0x0000000000000000000000000000000000000000 -- Burn ERC1155 Origin Apostle Mint Ticket
        and evt_tx_hash in (
            select evt_tx_hash from erc721_polygon.evt_Transfer
            where
                "from" = 0x0000000000000000000000000000000000000000 -- Mint ERC721 Origin Apostle
                and contract_address = 0x874f28BDCAa3Bb3c4551873CD2E6AA72ee8fB7Cd -- Apeiron Apostle Ticket
                and tokenId <= cast ('10000' as uint256) 
        )
)

select
    'Remaining Apostles for Migration' as migration_type,
    count(distinct id)*300 - cast(sum(value) as bigint) as total_amount
from apostle_migration

union all

select
    'Migrated Apostles' as migration_type,
    cast(sum(value) as bigint) as total_amount
from apostle_migration