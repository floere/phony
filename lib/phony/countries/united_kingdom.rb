# The United Kingdom uses a variable-length NDC code,
# thus we use a separate file to not let countries.rb explode.
#
# Note: The United Kingdom uses a variable NDC format from length 2 to 5.
# Most UK numbers have ten digits but a few have only nine digits.
# http://www.aa-asterisk.org.uk/index.php/Category:UK_Number_Plan
#
# The UK is special in formatting in that it uses:
#  a 2-4-4 formatting rule with area codes that are 2 digits long,
#  a 3-3-4 or 3-6 formatting rule with area codes that are 3 digits long,
#  a 4-6 or 4-5 formatting rule with area codes that are 4 digits long, and
#  a 5-5 or 5-4 formatting rule with area codes that are 5 digits long.
# There can be a mix of number lengths within a single area code.
#

mobile_ndc = [
  # Mobile [4+6].
  #
  ('7100'..'7599').to_a,
  '7624', # Isle of Man
  ('7700'..'7999').to_a,
].flatten

two_digit_ndc = [
  # Geographic [2+8] - includes (02x) 0 and (02x) 1 as NDO.
  #
  '20',   # London - (020) 3, (020) 7, (020) 8
  '23',   # Southampton - (023) 8, Portsmouth - (023) 9
  '24',   # Coventry - (024) 7
  '28',   # Northern Ireland - (028) but not (028) 5
  '29',   # Cardiff - (029) 2

  # Non-geographic [2+8].
  #
  '55',   # Corporate
  '56',   # LIECS/VoIP
  '70',   # Personal numbers
  '76',   # Pagers (not 7624, Mobile, Isle of Man)
]

# three_digit_ndc_with_nine_digits
  # Non-geographic [3+6].
  #
  # '500', # Freephone (9 digits) handled in specific rule, see below.
  # '800', # Freephone (9 digits) handled in specific rule, see below.

three_digit_ndc = [
  # Geographic [3+7] - includes (01xx) 0 and (01xx) 1 as NDO.
  #
  '113',  # Leeds
  '114',  # Sheffield
  '115',  # Nottingham
  '116',  # Leicester
  '117',  # Bristol
  '118',  # Reading
  '121',  # Birmingham
  '131',  # Edinburgh
  '141',  # Glasgow
  '151',  # Liverpool
  '161',  # Manchester
  '191',  # Tyneside, Sunderland and Durham (ELNS area)

  # Non-geographic [3+7].
  #
  '300', # Non-geographic numbers (NTS) charged at geographic rates.
  '301',
  '302',
  '303',
  '306',
  '308',
  '309',
  '330',
  '331',
  '332',
  '333',
  '336',
  '339',
  '342',
  '343',
  '344',
  '345',
  '370',
  '371',
  '372',
  '373',

  '800', # Freephone (10 digits) # 9 digits handled in specific rule, see below.
  '808', # Freephone (10 digits)

  '842', # Non-geographic numbers (NTS) with Service Charge up to 7p/min [3+7].
  '843',
  '844',
  '845',

  '870', # Non-geographic numbers (NTS) with Service Charge up to 13p/min [3+7].
  '871',
  '872',
  '873',

  '900', # Premium Rate Services (PRS) with Service Charge up to 300p/min [3+7].
  '901',
  '902',
  '903',
  '904',
  '905',
  '906',
  '907',
  '910',
  '911',
  '912',
  '913',
  '914',
  '915',
  '916',
  '917',
  '918',
  '919',

  '908', # Sexual Entertainment Services (SES) with Service Charge up to 300p/min [3+7].
  '909',
  '981',
  '982',
  '983',
  '984',
  '989',
]

# five_digit_ndc_with_nine_digits
  # Geographic [5+4] - includes (016977) 0 and (016977) 1 as NDO.
  #
  # '16977', # Brampton (contains both 4 and 5 digit numbers)
  #          # 9 digits handled in specific rule, see below.

five_digit_ndc = [
  # Geographic [5+5] - includes (01xxxx) 0 and (01xxxx) 1 as NDO.
  #
  # These areas use 5-5 format. One area has some 5-4 numbers too (see above).
  # They share their initial digits with area codes using 4-6 (and 4-5).
  '13873', # Langholm
  '15242', # Hornby
  '15394', # Hawkshead
  '15395', # Grange-over-Sands
  '15396', # Sedbergh
  '16973', # Wigton
  '16974', # Raughton Head
  '16977', # Brampton (contains both 4 and 5 digit numbers)
  '17683', # Appleby
  '17684', # Pooley Bridge
  '17687', # Keswick
  '19467', # Gosforth
]

variable_length_number = [
  # Geographic [4+6]/[4+5] - includes (01xxx) 0 and (01xxx) 1 as NDO.
  #
  # These 40 area codes have a mix of 4-6 and 4-5 numbers.
  # The three 'mixed' areas also have part of their number
  # range sub-allocated as 5-5.
  '1204', # Bolton
  '1208', # Bodmin
  '1254', # Blackburn
  '1276', # Camberley
  '1297', # Axminster
  '1298', # Buxton
  '1363', # Crediton
  '1364', # Ashburton
  '1384', # Dudley
  '1386', # Evesham
  '1404', # Honiton
  '1420', # Alton
  '1460', # Chard
  '1461', # Gretna
  '1480', # Huntingdon
  '1488', # Hungerford
  '1524', # Lancaster (Mixed area)
  '1527', # Redditch
  '1562', # Kidderminster
  '1566', # Launceston
  '1606', # Northwich
  '1629', # Matlock
  '1635', # Newbury
  '1647', # Moretonhampstead
  '1659', # Sanquhar
  '1695', # Skelmersdale
  '1726', # St Austell
  '1744', # St Helens
  '1750', # Selkirk
  '1768', # Penrith (Mixed area)
  '1827', # Tamworth
  '1837', # Okehampton
  '1884', # Tiverton
  '1900', # Workington
  '1905', # Worcester
  '1935', # Yeovil
  '1946', # Whitehaven (Mixed area)
  '1949', # Whatton
  '1963', # Wincanton
  '1995', # Garstang 
]

four_digit_ndc = [
  # Geographic [4+6] - includes (01xxx) 0 and (01xxx) 1 as NDO.
  #
  # These 542 area codes have only 4-6 numbers.
  # The three 'mixed' areas also have part of their number
  # range sub-allocated as 5-5 and one also has some 5-4.
  '1200', # Clitheroe
  '1202', # Bournemouth
  #1204     Bolton (see [4+6]/[4+5] areas)
  '1205', # Boston
  '1206', # Colchester
  '1207', # Consett
  #1208     Bodmin (see [4+6]/[4+5] areas)
  '1209', # Redruth, Cornwall
  '1223', # Cambridge
  '1224', # Aberdeen
  '1225', # Bath
  '1226', # Barnsley
  '1227', # Canterbury
  '1228', # Carlisle
  '1229', # Barrow-in-Furness and Millom (ELNS area)
  '1233', # Ashford, Kent
  '1234', # Bedford
  '1235', # Abingdon
  '1236', # Coatbridge
  '1237', # Bideford
  '1239', # Cardigan
  '1241', # Arbroath
  '1242', # Cheltenham
  '1243', # Chichester, West Sussex
  '1244', # Chester
  '1245', # Chelmsford
  '1246', # Chesterfield
  '1248', # Bangor, Gwynedd
  '1249', # Chippenham
  '1250', # Blairgowrie
  '1252', # Aldershot
  '1253', # Blackpool
  #1254     Blackburn (see [4+6]/[4+5] areas)
  '1255', # Clacton-on-Sea
  '1256', # Basingstoke
  '1257', # Coppull, Chorley
  '1258', # Blandford
  '1259', # Alloa
  '1260', # Congleton
  '1261', # Banff
  '1262', # Bridlington
  '1263', # Cromer
  '1264', # Andover
  '1267', # Carmarthen
  '1268', # Basildon
  '1269', # Ammanford
  '1270', # Crewe
  '1271', # Barnstaple
  '1273', # Brighton
  '1274', # Bradford
  '1275', # Clevedon, Bristol
  #1276     Camberley (see [4+6]/[4+5] areas)
  '1277', # Brentwood
  '1278', # Bridgwater
  '1279', # Bishop's Stortford
  '1280', # Buckingham
  '1282', # Burnley
  '1283', # Burton-on-Trent
  '1284', # Bury St Edmunds
  '1285', # Cirencester
  '1286', # Caernarfon
  '1287', # Guisborough
  '1288', # Bude
  '1289', # Berwick-upon-Tweed
  '1290', # Cumnock, Ayrshire
  '1291', # Chepstow
  '1292', # Ayr
  '1293', # Crawley
  '1294', # Ardrossan, Ayrshire
  '1295', # Banbury
  '1296', # Aylesbury
  #1297     Axminster (see [4+6]/[4+5] areas)
  #1298     Buxton (see [4+6]/[4+5] areas)
  '1299', # Bewdley
  '1300', # Cerne Abbas, Dorset
  '1301', # Arrochar
  '1302', # Doncaster
  '1303', # Folkestone
  '1304', # Dover
  '1305', # Dorchester
  '1306', # Dorking
  '1307', # Forfar
  '1308', # Bridport, Dorset
  '1309', # Forres
  '1320', # Fort Augustus
  '1322', # Dartford
  '1323', # Eastbourne
  '1324', # Falkirk
  '1325', # Darlington
  '1326', # Falmouth
  '1327', # Daventry
  '1328', # Fakenham
  '1329', # Fareham
  '1330', # Banchory, Deeside
  '1332', # Derby
  '1333', # Peat Inn and Leven, Fife
  '1334', # St Andrews, Fife
  '1335', # Ashbourne
  '1337', # Ladybank, Fife
  '1339', # Aboyne and Ballater (ELNS area)
  '1340', # Craigellachie, Elgin
  '1341', # Barmouth, Dolgellau
  '1342', # East Grinstead
  '1343', # Elgin
  '1344', # Bracknell, Easthampstead
  '1346', # Fraserburgh
  '1347', # Easingwold
  '1348', # Fishguard
  '1349', # Dingwall
  '1350', # Dunkeld
  '1352', # Mold, Flint
  '1353', # Ely
  '1354', # Chatteris and March, Cambridgeshire, Fenland
  '1355', # East Kilbride
  '1356', # Brechin, Edzell
  '1357', # Strathaven, East Kilbride
  '1358', # Ellon
  '1359', # Pakenham, Elmswell
  '1360', # Killearn, Drymen
  '1361', # Duns
  '1362', # Dereham
  #1363     Crediton (see [4+6]/[4+5] areas)
  #1364     Ashburton, Devon (see [4+6]/[4+5] areas)
  '1366', # Downham Market
  '1367', # Faringdon
  '1368', # Dunbar
  '1369', # Dunoon
  '1371', # Great Dunmow, Essex
  '1372', # Esher, Epsom
  '1373', # Frome
  '1375', # Grays Thurrock, Essex
  '1376', # Braintree, Essex
  '1377', # Driffield
  '1379', # Diss
  '1380', # Devizes
  '1381', # Fortrose
  '1382', # Dundee
  '1383', # Dunfermline
  #1384     Dudley (see [4+6]/[4+5] areas)
  #1386     Evesham (see [4+6]/[4+5] areas)
  '1387', # Dumfries (Mixed area)
  '1388', # Bishop Auckland, Durham and Stanhope (Eastgate) (ELNS area)
  '1389', # Dumbarton
  '1392', # Exeter
  '1394', # Felixstowe
  '1395', # Budleigh Salterton, Exmouth
  '1397', # Fort William
  '1398', # Dulverton, Exmoor
  '1400', # Honington
  '1403', # Horsham
  #1404     Honiton (see [4+6]/[4+5] areas)
  '1405', # Goole
  '1406', # Holbeach
  '1407', # Holyhead
  '1408', # Golspie
  '1409', # Holsworthy
  #1420     Alton (see [4+6]/[4+5] areas)
  '1422', # Halifax
  '1423', # Boroughbridge and Harrogate (ELNS area)
  '1424', # Hastings
  '1425', # Ringwood, Highcliffe; New Milton, Ashley
  '1427', # Gainsborough
  '1428', # Haslemere
  '1429', # Hartlepool
  '1430', # Market Weighton and North Cave, Howden (ELNS area)
  '1431', # Helmsdale
  '1432', # Hereford
  '1433', # Hathersage
  '1434', # Bellingham, Haltwhistle and Hexham (ELNS area)
  '1435', # Heathfield
  '1436', # Helensburgh
  '1437', # Clynderwen and Haverfordwest (ELNS area)
  '1438', # Stevenage, Hertfordshire
  '1439', # Helmsley
  '1440', # Haverhill
  '1442', # Hemel Hempstead
  '1443', # Pontypridd, Glamorgan
  '1444', # Haywards Heath
  '1445', # Gairloch
  '1446', # Barry, Glamorgan
  '1449', # Stowmarket, Gipping
  '1450', # Hawick
  '1451', # Stow-on-the-Wold, Gloucestershire
  '1452', # Gloucester
  '1453', # Dursley, Gloucestershire
  '1454', # Chipping Sodbury, Gloucestershire
  '1455', # Hinckley
  '1456', # Glenurquhart
  '1457', # Glossop
  '1458', # Glastonbury
  #1460     Chard, Ilminster (see [4+6]/[4+5] areas)
  #1461     Gretna (see [4+6]/[4+5] areas)
  '1462', # Hitchin
  '1463', # Inverness
  '1464', # Insch
  '1465', # Girvan
  '1466', # Huntly
  '1467', # Inverurie
  '1469', # Killingholme, Immingham
  '1470', # Edinbane, Isle of Skye
  '1471', # Broadford, Isle of Skye
  '1472', # Grimsby
  '1473', # Ipswich
  '1474', # Gravesend
  '1475', # Greenock
  '1476', # Grantham
  '1477', # Holmes Chapel
  '1478', # Portree, Isle of Skye
  '1479', # Grantown-on-Spey
  #1480     Huntingdon (see [4+6]/[4+5] areas)
  '1481', # Guernsey
  '1482', # Kingston-upon-Hull
  '1483', # Guildford
  '1484', # Huddersfield
  '1485', # Hunstanton
  '1487', # Warboys, Huntingdon
  #1488     Hungerford (see [4+6]/[4+5] areas)
  '1489', # Bishops Waltham, Hamble Valley
  '1490', # Corwen, Gwynedd
  '1491', # Henley-on-Thames
  '1492', # Colwyn Bay, Gwynedd
  '1493', # Great Yarmouth
  '1494', # High Wycombe
  '1495', # Pontypool, Gwent
  '1496', # Port Ellen, Islay
  '1497', # Hay-on-Wye
  '1499', # Inveraray
  '1501', # Harthill, Lothian
  '1502', # Lowestoft
  '1503', # Looe
  '1505', # Johnstone
  '1506', # Bathgate, Lothian
  '1507', # Alford (Lincs), Louth and Spilsby (Horncastle) (ELNS area)
  '1508', # Brooke
  '1509', # Loughborough
  '1520', # Lochcarron
  '1522', # Lincoln
  #1524     Lancaster (Mixed area) (see [4+6]/[4+5] areas)
  '1525', # Leighton Buzzard
  '1526', # Martin, Lincolnshire
  #1527     Redditch (see [4+6]/[4+5] areas)
  '1528', # Laggan, Badenoch
  '1529', # Sleaford, Lincolnshire
  '1530', # Coalville, Ashby-de-la-Zouch, Leicestershire
  '1531', # Ledbury
  '1534', # Jersey
  '1535', # Keighley
  '1536', # Kettering
  '1538', # Ipstones, Leek
  '1539', # Kendal (Mixed area)
  '1540', # Kingussie
  '1542', # Keith
  '1543', # Cannock, Lichfield
  '1544', # Kington
  '1545', # Llanarth, Ceredigion
  '1546', # Lochgilphead
  '1547', # Knighton
  '1548', # Kingsbridge
  '1549', # Lairg
  '1550', # Llandovery
  '1553', # King's Lynn
  '1554', # Llanelli
  '1555', # Lanark
  '1556', # Castle Douglas, Kirkcudbrightshire
  '1557', # Kirkcudbright
  '1558', # Llandeilo
  '1559', # Llandysul
  '1560', # Moscow
  '1561', # Laurencekirk
  #1562     Kidderminster (see [4+6]/[4+5] areas)
  '1563', # Kilmarnock
  '1564', # Lapworth, Knowle
  '1565', # Knutsford
  #1566     Launceston (see [4+6]/[4+5] areas)
  '1567', # Killin
  '1568', # Leominster
  '1569', # Stonehaven, Laurencekirk
  '1570', # Lampeter
  '1571', # Lochinver
  '1572', # Oakham
  '1573', # Kelso
  '1575', # Kirriemuir
  '1576', # Lockerbie
  '1577', # Kinross
  '1578', # Lauder
  '1579', # Liskeard
  '1580', # Cranbrook, Kent
  '1581', # New Luce, Luce
  '1582', # Luton
  '1583', # Carradale, Kintyre
  '1584', # Ludlow
  '1586', # Campbeltown, Kintyre
  '1588', # Bishops Castle, Ludlow
  '1590', # Lymington
  '1591', # Llanwrtyd Wells
  '1592', # Kirkcaldy
  '1593', # Lybster
  '1594', # Lydney
  '1595', # Lerwick, Foula and Fair Isle
  '1597', # Llandrindod Wells
  '1598', # Lynton
  '1599', # Kyle
  '1600', # Monmouth
  '1603', # Norwich
  '1604', # Northampton
  #1606     Northwich (see [4+6]/[4+5] areas)
  '1608', # Chipping Norton
  '1609', # Northallerton
  '1620', # North Berwick
  '1621', # Maldon
  '1622', # Maidstone
  '1623', # Mansfield
  '1624', # Isle of Man
  '1625', # Macclesfield
  '1626', # Newton Abbot
  '1628', # Maidenhead
  #1629     Matlock (see [4+6]/[4+5] areas)
  '1630', # Market Drayton
  '1631', # Oban
  #1632     Numbers for Drama
  '1633', # Newport
  '1634', # Medway
  #1635     Newbury (see [4+6]/[4+5] areas)
  '1636', # Newark-on-Trent
  '1637', # Newquay
  '1638', # Newmarket
  '1639', # Neath
  '1641', # Strathy, Melvich
  '1642', # Middlesbrough
  '1643', # Minehead
  '1644', # New Galloway
  '1646', # Milford Haven
  #1647     Moretonhampstead (see [4+6]/[4+5] areas)
  '1650', # Cemmaes Road, Machynlleth
  '1651', # Oldmeldrum
  '1652', # Brigg, North Kelsey
  '1653', # Malton
  '1654', # Machynlleth
  '1655', # Maybole
  '1656', # Bridgend
  #1659     Sanquhar, Nithsdale (see [4+6]/[4+5] areas)
  '1661', # Prudhoe, Northumberland
  '1663', # New Mills
  '1664', # Melton Mowbray
  '1665', # Alnwick, Northumberland
  '1666', # Malmesbury
  '1667', # Nairn
  '1668', # Bamburgh, Northumberland
  '1669', # Rothbury, Northumberland
  '1670', # Morpeth
  '1671', # Newton Stewart
  '1672', # Marlborough
  '1673', # Market Rasen
  '1674', # Montrose
  '1675', # Coleshill, Warwickshire, Meriden
  '1676', # Meriden
  '1677', # Bedale, North Riding
  '1678', # Bala, Meirionydd
  '1680', # Craignure, Isle of Mull
  '1681', # Fionnphort, Isle of Mull
  '1683', # Moffat
  '1684', # Malvern
  '1685', # Merthyr Tydfil
  '1686', # Llanidloes and Newtown (ELNS area)
  '1687', # Mallaig
  '1688', # Tobermory, Isle of Mull
  '1689', # Orpington
  '1690', # Betws-y-Coed
  '1691', # Oswestry
  '1692', # North Walsham
  '1694', # Church Stretton
  #1695     Skelmersdale (see [4+6]/[4+5] areas)
  '1697', # Brampton (Mixed area)
  '1698', # Motherwell
  '1700', # Rothesay
  '1702', # Southend-on-Sea
  '1704', # Southport
  '1706', # Rochdale, Rossendale
  '1707', # Welwyn Garden City, Hatfield and Potters Bar
  '1708', # Romford
  '1709', # Rotherham
  '1720', # Isles of Scilly
  '1721', # Peebles
  '1722', # Salisbury
  '1723', # Scarborough
  '1724', # Scunthorpe
  '1725', # Rockbourne
  #1726     St Austell (see [4+6]/[4+5] areas)
  '1727', # St Albans
  '1728', # Saxmundham
  '1729', # Settle, Ribblesdale
  '1730', # Petersfield
  '1732', # Sevenoaks
  '1733', # Peterborough
  '1736', # Penzance
  '1737', # Redhill
  '1738', # Perth
  '1740', # Sedgefield
  '1743', # Shrewsbury
  #1744     St Helens (see [4+6]/[4+5] areas)
  '1745', # Rhyl
  '1746', # Bridgnorth, Shropshire
  '1747', # Shaftesbury
  '1748', # Richmond
  '1749', # Shepton Mallet
  #1750     Selkirk (see [4+6]/[4+5] areas)
  '1751', # Pickering
  '1752', # Plymouth
  '1753', # Slough
  '1754', # Skegness
  '1756', # Skipton
  '1757', # Selby
  '1758', # Pwllheli
  '1759', # Pocklington
  '1760', # Swaffham
  '1761', # Temple Cloud, Somerset
  '1763', # Royston
  '1764', # Crieff, Ruthven
  '1765', # Ripon
  '1766', # Porthmadog
  '1767', # Sandy
  #1768     Penrith (Mixed area) (see [4+6]/[4+5] areas)
  '1769', # South Molton
  '1770', # Isle of Arran
  '1771', # Maud
  '1772', # Preston
  '1773', # Ripley
  '1775', # Spalding
  '1776', # Stranraer
  '1777', # Retford
  '1778', # Market Deeping/Bourne
  '1779', # Peterhead
  '1780', # Stamford
  '1782', # Stoke-on-Trent
  '1784', # Staines
  '1785', # Stafford
  '1786', # Stirling
  '1787', # Sudbury
  '1788', # Rugby
  '1789', # Stratford-upon-Avon
  '1790', # Spilsby
  '1792', # Swansea
  '1793', # Swindon
  '1794', # Romsey
  '1795', # Sittingbourne, Sheppey
  '1796', # Pitlochry
  '1797', # Rye
  '1798', # Pulborough, Sussex
  '1799', # Saffron Walden
  '1803', # Torquay
  '1805', # Torrington
  '1806', # Voe, Shetland
  '1807', # Ballindalloch, Tomintoul
  '1808', # Tomatin
  '1809', # Tomdoun
  '1821', # Kinrossie, Tayside
  '1822', # Tavistock
  '1823', # Taunton
  '1824', # Ruthin, Vale of Clwyd
  '1825', # Uckfield
  #1827     Tamworth (see [4+6]/[4+5] areas)
  '1828', # Coupar Angus, Tayside
  '1829', # Tarporley
  '1830', # Kirkwhelpington
  '1832', # Clopton, Oundle
  '1833', # Barnard Castle, Teesdale
  '1834', # Narberth, Tenby
  '1835', # St Boswells
  #1837     Okehampton (see [4+6]/[4+5] areas)
  '1838', # Dalmally, Tyndrum
  '1840', # Camelford, Tintagel
  '1841', # Padstow, Newquay
  '1842', # Thetford
  '1843', # Thanet
  '1844', # Thame
  '1845', # Thirsk
  '1847', # Thurso and Tongue (ELNS area)
  '1848', # Thornhill
  '1851', # Great Bernera and Stornoway (ELNS area)
  '1852', # Kilmelford
  '1854', # Ullapool
  '1855', # Ballachulish
  '1856', # Orkney
  '1857', # Sanday
  '1858', # Market Harborough
  '1859', # Harris
  '1862', # Tain
  '1863', # Ardgay, Tain
  '1864', # Tinto, Abington, Crawford
  '1865', # Oxford
  '1866', # Kilchrenan
  '1869', # Bicester, Oxfordshire
  '1870', # Isle of Benbecula
  '1871', # Castlebay
  '1872', # Truro
  '1873', # Abergavenny, Usk
  '1874', # Brecon, Usk
  '1875', # Tranent
  '1876', # Lochmaddy
  '1877', # Callander, Trossachs
  '1878', # Lochboisdale
  '1879', # Scarinish, Tiree
  '1880', # Tarbert
  '1882', # Kinloch Rannoch, Tummel Bridge
  '1883', # Caterham
  #1884     Tiverton (see [4+6]/[4+5] areas)
  '1885', # Pencombe
  '1886', # Bromyard, Teme Valley
  '1887', # Aberfeldy, Tay Valley
  '1888', # Turriff
  '1889', # Rugeley, Uttoxeter
  '1890', # Ayton, Berwickshire and Coldstream, Tweed (ELNS area)
  '1892', # Tunbridge Wells
  '1895', # Uxbridge
  '1896', # Galashiels, Tweed
  '1899', # Biggar, Tweed
  #1900     Workington (see [4+6]/[4+5] areas)
  '1902', # Wolverhampton
  '1903', # Worthing
  '1904', # York
  #1905     Worcester (see [4+6]/[4+5] areas)
  '1908', # Milton Keynes, Wolverton
  '1909', # Worksop
  '1920', # Ware
  '1922', # Walsall
  '1923', # Watford
  '1924', # Wakefield
  '1925', # Warrington
  '1926', # Warwick
  '1928', # Runcorn, Warrington
  '1929', # Wareham
  '1931', # Shap, Westmorland
  '1932', # Weybridge
  '1933', # Wellingborough
  '1934', # Weston-super-Mare
  #1935     Yeovil (see [4+6]/[4+5] areas)
  '1937', # Wetherby
  '1938', # Welshpool
  '1939', # Wem
  '1942', # Wigan
  '1943', # Guiseley, Wharfedale
  '1944', # West Heslerton
  '1945', # Wisbech
  #1946     Whitehaven (Mixed area) (see [4+6]/[4+5] areas)
  '1947', # Whitby
  '1948', # Whitchurch
  #1949     Whatton (see [4+6]/[4+5] areas)
  '1950', # Sandwick, Yell
  '1951', # Colonsay
  '1952', # Telford, Wellington
  '1953', # Wymondham
  '1954', # Madingley, Willingham
  '1955', # Wick
  '1957', # Mid Yell, Yell
  '1959', # Westerham, West Kent
  '1962', # Winchester
  #1963     Wincanton (see [4+6]/[4+5] areas)
  '1964', # Hornsea and Patrington, Withernsea (ELNS area)
  '1967', # Strontian
  '1968', # Penicuik, West Linton
  '1969', # Leyburn, Wensleydale
  '1970', # Aberystwyth, Ystwyth
  '1971', # Scourie, Wrath
  '1972', # Glenborrodale
  '1974', # Llanon, Ystwyth
  '1975', # Alford, Aberdeenshire and Strathdon, Water (ELNS area)
  '1977', # Pontefract, West Riding
  '1978', # Wrexham
  '1980', # Amesbury, Wiltshire
  '1981', # Wormbridge
  '1982', # Builth Wells
  '1983', # Isle of Wight
  '1984', # Watchet, Williton
  '1985', # Warminster
  '1986', # Bungay, Waveney
  '1987', # Ebbsfleet
  '1988', # Wigtown
  '1989', # Ross-on-Wye, Wye
  '1992', # Lea Valley, Waltham Cross
  '1993', # Witney
  '1994', # St Clears, West Wales
  #1995     Garstang, Wyre (see [4+6]/[4+5] areas)
  '1997', # Strathpeffer, Wyvis
]

Phony.define do
  country '44', one_of(mobile_ndc)             >> split(6)   | # 4-6
                one_of(two_digit_ndc)          >> split(4,4) | # 2-4-4
                match(/^([58]00)\d{6}$/)       >> split(6)   | # 3-6, Special handling for 500 and 800.
                one_of(three_digit_ndc)        >> split(3,4) | # 3-3-4
                match(/^(16977)\d{4}$/)        >> split(4)   | # 5-4, Special handling for 16977.
                one_of(five_digit_ndc)         >> split(5)   | # 5-5
                one_of(variable_length_number) >> split(6)   | # 4-6 and 4-5, in 40 areas.
                one_of(four_digit_ndc)         >> split(6)   | # 4-6
                fixed(4)                       >> split(6)     # Catchall for undefined numbers.
end