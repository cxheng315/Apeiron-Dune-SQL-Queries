select
  date_trunc('month', evt_block_time) as date,
  sum(value) filter (where "from" = 0xd2B453d1f3Cc21B68ba174011A783feC2f82a078) as monthly_airdrop,
  sum(value) filter (where to = 0xd2B453d1f3Cc21B68ba174011A783feC2f82a078) as monthly_recover
from erc1155_polygon.evt_TransferSingle
where
  contract_address = 0x2953399124f0cbb46d2cbacd8a89cf0599974963
  and id = cast ( '95304309179396549571695629844645662043614112156987503316211189529370918135568' as uint256 )
  and ("from" = 0xd2B453d1f3Cc21B68ba174011A783feC2f82a078 or to = 0xd2B453d1f3Cc21B68ba174011A783feC2f82a078)
group by date_trunc('month', evt_block_time)