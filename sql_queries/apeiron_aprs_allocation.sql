with
planet_transfer as (
    select 
        "from",
        to, 
        tokenId
    from erc721_polygon.evt_Transfer
    where 
        contract_address in (
            0x24f9b0837424c62d2247d8a11a6d6139e4ab5ed2,
            0x2ef1ca1a9a4a6b05eb784db98befb06d24859b16
        )
        and tokenId <= cast( '4585' as uint256 ) -- primeval planet
        and tokenId not between cast ( '1064' as uint256 ) and cast ( '1132' as uint256 ) -- burned Arcane
        and tokenId not between cast ( '2371' as uint256 ) and cast ( '3187' as uint256 ) -- burned Mythic
), -- planet_transfer

planet_hold as (
    select
        address,
        sum(primal_sum) as primal_sum,
        sum(divine_sum) as divine_sum,
        sum(arcane_sum) as arcane_sum,
        sum(mythic_sum) as mythic_sum,
        sum(elemental_sum) as elemental_sum
    from (
        select
            count(tokenId) filter (where tokenId >= cast( '0' as uint256 ) and tokenId <= cast( '13' as uint256 )) as primal_sum,
            count(tokenId) filter (where tokenId >= cast( '14' as uint256 ) and tokenId <= cast( '386' as uint256 )) as divine_sum,
            count(tokenId) filter (where tokenId >= cast( '387' as uint256 ) and tokenId <= cast( '1132' as uint256 )) as arcane_sum,
            count(tokenId) filter (where tokenId >= cast( '1133' as uint256 ) and tokenId <= cast( '3187' as uint256 )) as mythic_sum,
            count(tokenId) filter (where tokenId >= cast( '3188' as uint256 ) and tokenId <= cast( '4585' as uint256 )) as elemental_sum,
            to as address
        from planet_transfer
        group by to
        union all
        select
            -count(tokenId) filter (where tokenId >= cast( '0' as uint256 ) and tokenId <= cast( '13' as uint256 )) as primal_sum,
            -count(tokenId) filter (where tokenId >= cast( '14' as uint256 ) and tokenId <= cast( '386' as uint256 )) as divine_sum,
            -count(tokenId) filter (where tokenId >= cast( '387' as uint256 ) and tokenId <= cast( '1132' as uint256 )) as arcane_sum,
            -count(tokenId) filter (where tokenId >= cast( '1133' as uint256 ) and tokenId <= cast( '3187' as uint256 )) as mythic_sum,
            -count(tokenId) filter (where tokenId >= cast( '3188' as uint256 ) and tokenId <= cast( '4585' as uint256 )) as elemental_sum,
            "from" as address
        from planet_transfer
        group by "from"
    )

    group by address
), -- planet_hold

apostle_transfer as (
    select
        "from",
        to,
        id,
        value
    from erc1155_polygon.evt_TransferSingle
    where
        contract_address in (
            0x2953399124F0cBB46d2CbACD8A89cF0599974963,
            0xa335cEbBD323f8152c75136a4B1edD04E74F6D36
        )

        and id in ( select id from query_2336983 ) -- Apostle ID
), -- apostle_transfer

apostle_hold as (
    select
        address,
        sum(warrior_sum) as warrior_sum,
        sum(mage_sum) as mage_sum,
        sum(rogue_sum) as rogue_sum,
        sum(bard_sum) as bard_sum,
        sum(guardian_sum) as guardian_sum,
        sum(hunter_sum) as hunter_sum,
        sum(priest_sum) as priest_sum,
        sum(shaman_sum) as shaman_sum,
        sum(summoner_sum) as summoner_sum,
        sum(dragoon_sum) as dragoon_sum,
        sum(knight_sum) as knight_sum,
        sum(berserker_sum) as berserker_sum
    from (
        select
            sum( cast ( value as bigint ) ) filter (where id = cast( '95304309179396549571695629844645662043614112156987503316211189513977755337004' as uint256 )) as warrior_sum,
            sum( cast ( value as bigint ) ) filter (where id = cast( '95304309179396549571695629844645662043614112156987503316211189516176778592556' as uint256 )) as mage_sum,
            sum( cast ( value as bigint ) ) filter (where id = cast( '95304309179396549571695629844645662043614112156987503316211189517276290220332' as uint256 )) as rogue_sum,
            sum( cast ( value as bigint ) ) filter (where id = cast( '95304309179396549571695629844645662043614112156987503316211189518375801848108' as uint256 )) as bard_sum,
            sum( cast ( value as bigint ) ) filter (where id = cast( '95304309179396549571695629844645662043614112156987503316211189519475313475884' as uint256 )) as guardian_sum,
            sum( cast ( value as bigint ) ) filter (where id = cast( '95304309179396549571695629844645662043614112156987503316211189520574825103660' as uint256 )) as hunter_sum,
            sum( cast ( value as bigint ) ) filter (where id = cast( '95304309179396549571695629844645662043614112156987503316211189521674336731436' as uint256 )) as priest_sum,
            sum( cast ( value as bigint ) ) filter (where id = cast( '95304309179396549571695629844645662043614112156987503316211189522773848359212' as uint256 )) as shaman_sum,
            sum( cast ( value as bigint ) ) filter (where id = cast( '95304309179396549571695629844645662043614112156987503316211189523873359986988' as uint256 )) as summoner_sum,
            sum( cast ( value as bigint ) ) filter (where id = cast( '95304309179396549571695629844645662043614112156987503316211189524972871614764' as uint256 )) as dragoon_sum,
            sum( cast ( value as bigint ) ) filter (where id = cast( '95304309179396549571695629844645662043614112156987503316211189526072383242540' as uint256 )) as knight_sum,
            sum( cast ( value as bigint ) ) filter (where id = cast( '95304309179396549571695629844645662043614112156987503316211189528271406498092' as uint256 )) as berserker_sum,
            to as address
        from apostle_transfer
        group by to
        union all
        select
            -sum( cast ( value as bigint ) ) filter (where id = cast( '95304309179396549571695629844645662043614112156987503316211189513977755337004' as uint256 )) as warrior_sum,
            -sum( cast ( value as bigint ) ) filter (where id = cast( '95304309179396549571695629844645662043614112156987503316211189516176778592556' as uint256 )) as mage_sum,
            -sum( cast ( value as bigint ) ) filter (where id = cast( '95304309179396549571695629844645662043614112156987503316211189517276290220332' as uint256 )) as rogue_sum,
            -sum( cast ( value as bigint ) ) filter (where id = cast( '95304309179396549571695629844645662043614112156987503316211189518375801848108' as uint256 )) as bard_sum,
            -sum( cast ( value as bigint ) ) filter (where id = cast( '95304309179396549571695629844645662043614112156987503316211189519475313475884' as uint256 )) as guardian_sum,
            -sum( cast ( value as bigint ) ) filter (where id = cast( '95304309179396549571695629844645662043614112156987503316211189520574825103660' as uint256 )) as hunter_sum,
            -sum( cast ( value as bigint ) ) filter (where id = cast( '95304309179396549571695629844645662043614112156987503316211189521674336731436' as uint256 )) as priest_sum,
            -sum( cast ( value as bigint ) ) filter (where id = cast( '95304309179396549571695629844645662043614112156987503316211189522773848359212' as uint256 )) as shaman_sum,
            -sum( cast ( value as bigint ) ) filter (where id = cast( '95304309179396549571695629844645662043614112156987503316211189523873359986988' as uint256 )) as summoner_sum,
            -sum( cast ( value as bigint ) ) filter (where id = cast( '95304309179396549571695629844645662043614112156987503316211189524972871614764' as uint256 )) as dragoon_sum,
            -sum( cast ( value as bigint ) ) filter (where id = cast( '95304309179396549571695629844645662043614112156987503316211189526072383242540' as uint256 )) as knight_sum,
            -sum( cast ( value as bigint ) ) filter (where id = cast( '95304309179396549571695629844645662043614112156987503316211189528271406498092' as uint256 )) as berserker_sum,
            "from" as address
        from apostle_transfer
        group by "from"
    )

    group by address
), -- apostle_hold

asset_hold as (
    select
        coalesce(planet_hold.address, apostle_hold.address) as address,
        coalesce(primal_sum, 0) as primal_sum,
        coalesce(divine_sum, 0) as divine_sum,
        coalesce(arcane_sum, 0) as arcane_sum,
        coalesce(mythic_sum, 0) as mythic_sum,
        coalesce(elemental_sum, 0) as elemental_sum,
        coalesce(
            (
                case when warrior_sum >= 1 then 1 else 0 end +
                case when mage_sum >= 1 then 1 else 0 end +
                case when rogue_sum >= 1 then 1 else 0 end +
                case when bard_sum >= 1 then 1 else 0 end +
                case when guardian_sum >= 1 then 1 else 0 end +
                case when hunter_sum >= 1 then 1 else 0 end +
                case when priest_sum >= 1 then 1 else 0 end +
                case when shaman_sum >= 1 then 1 else 0 end +
                case when summoner_sum >= 1 then 1 else 0 end +
                case when dragoon_sum >= 1 then 1 else 0 end +
                case when knight_sum >= 1 then 1 else 0 end +
                case when berserker_sum >= 1 then 1 else 0 end
            ), 0) as unique_apostles_count
    from planet_hold
    full join apostle_hold on apostle_hold.address = planet_hold.address
), -- asset_hold

aprs_slot as (
    select
        address,
        primal_sum,
        divine_sum,
        arcane_sum,
        mythic_sum,
        elemental_sum,
        case when ( unique_apostles_count >= 7 ) then true else false end as "7+ Apostle",
        primal_sum * 19800 + divine_sum * 6000 + arcane_sum * 1800 + mythic_sum * 900 + elemental_sum * 300 + case when ( unique_apostles_count >= 7 ) then 600 else 0 end as aprs_slot
    from asset_hold
    where
        address not in ( select address from query_2338429 )
        and (
            ( primal_sum + divine_sum + arcane_sum + mythic_sum + elemental_sum ) >= 1
            or unique_apostles_count >= 7
            )
) -- aprs_slot

select 
    row_number() over ( order by aprs_slot desc, primal_sum desc, divine_sum desc, arcane_sum desc, mythic_sum desc, elemental_sum desc, "7+ Apostle" desc ) as no,
    * 
from aprs_slot
order by aprs_slot desc, primal_sum desc, divine_sum desc, arcane_sum desc, mythic_sum desc, elemental_sum desc, "7+ Apostle" desc