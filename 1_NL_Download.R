################################################################################
# Date: 23 June, 2020
# Author: David Chen 


# Purpose: 
#   Download and extract night light images from EOG
#   VIIRS Day/Night Band Nighttime Lights
#   Source: https://eogdata.mines.edu/download_dnb_composites.html

# Input:
#   User should specify the output folder. If less years/tiles are desired,
#     one needs to specify those.

# Output:
#   All the nightlight images downloaded into the specified output folder.
#   There will be a folder for each tile (e.g. folder Tile2, Tile5). 

# Note:
### You can't really  automate links since part of the name is the creation date
### and time of the file creation. Need to manually specify links.

################################################################################

print("We're starting the process!")

# All the file links. Order doesn't matter too much since we can reorder
Tile2_2013 <-
  c("https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201301/vcmcfg/SVDNB_npp_20130101-20130131_75N060W_vcmcfg_v10_c201605121529.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201302/vcmcfg/SVDNB_npp_20130201-20130228_75N060W_vcmcfg_v10_c201605131247.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201303/vcmcfg/SVDNB_npp_20130301-20130331_75N060W_vcmcfg_v10_c201605131250.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201304/vcmcfg/SVDNB_npp_20130401-20130430_75N060W_vcmcfg_v10_c201605131251.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201305/vcmcfg/SVDNB_npp_20130501-20130531_75N060W_vcmcfg_v10_c201605131256.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201306/vcmcfg/SVDNB_npp_20130601-20130630_75N060W_vcmcfg_v10_c201605131304.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201307/vcmcfg/SVDNB_npp_20130701-20130731_75N060W_vcmcfg_v10_c201605131305.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201308/vcmcfg/SVDNB_npp_20130801-20130831_75N060W_vcmcfg_v10_c201605131312.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201309/vcmcfg/SVDNB_npp_20130901-20130930_75N060W_vcmcfg_v10_c201605131325.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201310/vcmcfg/SVDNB_npp_20131001-20131031_75N060W_vcmcfg_v10_c201605131331.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201311/vcmcfg/SVDNB_npp_20131101-20131130_75N060W_vcmcfg_v10_c201605131332.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201312/vcmcfg/SVDNB_npp_20131201-20131231_75N060W_vcmcfg_v10_c201605131341.tgz"
  )

Tile2_2014 <-
  c("https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201401/vcmcfg/SVDNB_npp_20140101-20140131_75N060W_vcmcfg_v10_c201506171538.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201402/vcmcfg/SVDNB_npp_20140201-20140228_75N060W_vcmcfg_v10_c201507201052.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201403/vcmcfg/SVDNB_npp_20140301-20140331_75N060W_vcmcfg_v10_c201506121552.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201404/vcmcfg/SVDNB_npp_20140401-20140430_75N060W_vcmcfg_v10_c201507201613.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201405/vcmcfg/SVDNB_npp_20140501-20140531_75N060W_vcmcfg_v10_c201502061154.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201406/vcmcfg/SVDNB_npp_20140601-20140630_75N060W_vcmcfg_v10_c201502121156.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201407/vcmcfg/SVDNB_npp_20140701-20140731_75N060W_vcmcfg_v10_c201506231100.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201408/vcmcfg/SVDNB_npp_20140801-20140831_75N060W_vcmcfg_v10_c201508131459.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201409/vcmcfg/SVDNB_npp_20140901-20140930_75N060W_vcmcfg_v10_c201502251400.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201410/vcmcfg/SVDNB_npp_20141001-20141031_75N060W_vcmcfg_v10_c201502231115.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201411/vcmcfg/SVDNB_npp_20141101-20141130_75N060W_vcmcfg_v10_c201502231455.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201412/vcmcfg/SVDNB_npp_20141201-20141231_75N060W_vcmcfg_v10_c201502231125.tgz"
  )

Tile2_2015 <-
  c("https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201501/vcmcfg/SVDNB_npp_20150101-20150131_75N060W_vcmcfg_v10_c201505111709.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201502/vcmcfg/SVDNB_npp_20150201-20150228_75N060W_vcmcfg_v10_c201504281504.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201503/vcmcfg/SVDNB_npp_20150301-20150331_75N060W_vcmcfg_v10_c201505191916.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201504/vcmcfg/SVDNB_npp_20150401-20150430_75N060W_vcmcfg_v10_c201506011707.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201505/vcmcfg/SVDNB_npp_20150501-20150531_75N060W_vcmcfg_v10_c201506161325.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201506/vcmcfg/SVDNB_npp_20150601-20150630_75N060W_vcmcfg_v10_c201508141522.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201507/vcmcfg/SVDNB_npp_20150701-20150731_75N060W_vcmcfg_v10_c201509151839.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201508/vcmcfg/SVDNB_npp_20150801-20150831_75N060W_vcmcfg_v10_c201509301759.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201509/vcmcfg/SVDNB_npp_20150901-20150930_75N060W_vcmcfg_v10_c201511121210.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201510/vcmcfg/SVDNB_npp_20151001-20151031_75N060W_vcmcfg_v10_c201511181404.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201511/vcmcfg/SVDNB_npp_20151101-20151130_75N060W_vcmcfg_v10_c201512121648.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201512/vcmcfg/SVDNB_npp_20151201-20151231_75N060W_vcmcfg_v10_c201601251413.tgz"
  )

Tile2_2016 <-
  c("https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201601/vcmcfg/SVDNB_npp_20160101-20160131_75N060W_vcmcfg_v10_c201603132032.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201602/vcmcfg/SVDNB_npp_20160201-20160229_75N060W_vcmcfg_v10_c201603152010.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201603/vcmcfg/SVDNB_npp_20160301-20160331_75N060W_vcmcfg_v10_c201604191144.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201604/vcmcfg/SVDNB_npp_20160401-20160430_75N060W_vcmcfg_v10_c201606140957.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201605/vcmcfg/SVDNB_npp_20160501-20160531_75N060W_vcmcfg_v10_c201606281430.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201606/vcmcfg/SVDNB_npp_20160601-20160630_75N060W_vcmcfg_v10_c201608101832.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201607/vcmcfg/SVDNB_npp_20160701-20160731_75N060W_vcmcfg_v10_c201609121310.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201608/vcmcfg/SVDNB_npp_20160801-20160831_75N060W_vcmcfg_v10_c201610041107.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201609/vcmcfg/SVDNB_npp_20160901-20160930_75N060W_vcmcfg_v10_c201610280941.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201610/vcmcfg/SVDNB_npp_20161001-20161031_75N060W_vcmcfg_v10_c201612011122.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201611/vcmcfg/SVDNB_npp_20161101-20161130_75N060W_vcmcfg_v10_c201612191231.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201612/vcmcfg/SVDNB_npp_20161201-20161231_75N060W_vcmcfg_v10_c201701271136.tgz"
  )

Tile2_2017 <-
  c("https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201701/vcmcfg/SVDNB_npp_20170101-20170131_75N060W_vcmcfg_v10_c201702241223.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201702/vcmcfg/SVDNB_npp_20170201-20170228_75N060W_vcmcfg_v10_c201703012030.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201703/vcmcfg/SVDNB_npp_20170301-20170331_75N060W_vcmcfg_v10_c201705020851.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201704/vcmcfg/SVDNB_npp_20170401-20170430_75N060W_vcmcfg_v10_c201705011300.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201705/vcmcfg/SVDNB_npp_20170501-20170531_75N060W_vcmcfg_v10_c201706021500.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201706/vcmcfg/SVDNB_npp_20170601-20170630_75N060W_vcmcfg_v10_c201707021700.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201707/vcmcfg/SVDNB_npp_20170701-20170731_75N060W_vcmcfg_v10_c201708061230.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201708/vcmcfg/SVDNB_npp_20170801-20170831_75N060W_vcmcfg_v10_c201709051000.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201709/vcmcfg/SVDNB_npp_20170901-20170930_75N060W_vcmcfg_v10_c201710041620.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201710/vcmcfg/SVDNB_npp_20171001-20171031_75N060W_vcmcfg_v10_c201711021230.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201711/vcmcfg/SVDNB_npp_20171101-20171130_75N060W_vcmcfg_v10_c201712040930.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201712/vcmcfg/SVDNB_npp_20171201-20171231_75N060W_vcmcfg_v10_c201801021747.tgz"
  )

Tile2_2018 <-
  c("https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201801/vcmcfg/SVDNB_npp_20180101-20180131_75N060W_vcmcfg_v10_c201805221252.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201802/vcmcfg/SVDNB_npp_20180201-20180228_75N060W_vcmcfg_v10_c201803012000.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201803/vcmcfg/SVDNB_npp_20180301-20180331_75N060W_vcmcfg_v10_c201804022005.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201804/vcmcfg/SVDNB_npp_20180401-20180430_75N060W_vcmcfg_v10_c201805021400.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201805/vcmcfg/SVDNB_npp_20180501-20180531_75N060W_vcmcfg_v10_c201806061100.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201806/vcmcfg/SVDNB_npp_20180601-20180630_75N060W_vcmcfg_v10_c201904251200.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201807/vcmcfg/SVDNB_npp_20180701-20180731_75N060W_vcmcfg_v10_c201812111300.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201808/vcmcfg/SVDNB_npp_20180801-20180831_75N060W_vcmcfg_v10_c201809070900.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201809/vcmcfg/SVDNB_npp_20180901-20180930_75N060W_vcmcfg_v10_c201810250900.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201810/vcmcfg/SVDNB_npp_20181001-20181031_75N060W_vcmcfg_v10_c201811131000.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201811/vcmcfg/SVDNB_npp_20181101-20181130_75N060W_vcmcfg_v10_c201812081230.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201812/vcmcfg/SVDNB_npp_20181201-20181231_75N060W_vcmcfg_v10_c201902122100.tgz"
  )

############################################

Tile5_2013 <-
  c("https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201301/vcmcfg/SVDNB_npp_20130101-20130131_00N060W_vcmcfg_v10_c201605121529.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201302/vcmcfg/SVDNB_npp_20130201-20130228_00N060W_vcmcfg_v10_c201605131247.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201303/vcmcfg/SVDNB_npp_20130301-20130331_00N060W_vcmcfg_v10_c201605131250.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201304/vcmcfg/SVDNB_npp_20130401-20130430_00N060W_vcmcfg_v10_c201605131251.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201305/vcmcfg/SVDNB_npp_20130501-20130531_00N060W_vcmcfg_v10_c201605131256.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201306/vcmcfg/SVDNB_npp_20130601-20130630_00N060W_vcmcfg_v10_c201605131304.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201307/vcmcfg/SVDNB_npp_20130701-20130731_00N060W_vcmcfg_v10_c201605131305.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201308/vcmcfg/SVDNB_npp_20130801-20130831_00N060W_vcmcfg_v10_c201605131312.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201309/vcmcfg/SVDNB_npp_20130901-20130930_00N060W_vcmcfg_v10_c201605131325.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201310/vcmcfg/SVDNB_npp_20131001-20131031_00N060W_vcmcfg_v10_c201605131331.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201311/vcmcfg/SVDNB_npp_20131101-20131130_00N060W_vcmcfg_v10_c201605131332.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201312/vcmcfg/SVDNB_npp_20131201-20131231_00N060W_vcmcfg_v10_c201605131341.tgz"
  )

Tile5_2014 <-
  c("https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201401/vcmcfg/SVDNB_npp_20140101-20140131_00N060W_vcmcfg_v10_c201506171538.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201402/vcmcfg/SVDNB_npp_20140201-20140228_00N060W_vcmcfg_v10_c201507201052.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201403/vcmcfg/SVDNB_npp_20140301-20140331_00N060W_vcmcfg_v10_c201506121552.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201404/vcmcfg/SVDNB_npp_20140401-20140430_00N060W_vcmcfg_v10_c201507201613.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201405/vcmcfg/SVDNB_npp_20140501-20140531_00N060W_vcmcfg_v10_c201502061154.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201406/vcmcfg/SVDNB_npp_20140601-20140630_00N060W_vcmcfg_v10_c201502121156.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201407/vcmcfg/SVDNB_npp_20140701-20140731_00N060W_vcmcfg_v10_c201506231100.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201408/vcmcfg/SVDNB_npp_20140801-20140831_00N060W_vcmcfg_v10_c201508131459.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201409/vcmcfg/SVDNB_npp_20140901-20140930_00N060W_vcmcfg_v10_c201502251400.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201410/vcmcfg/SVDNB_npp_20141001-20141031_00N060W_vcmcfg_v10_c201502231115.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201411/vcmcfg/SVDNB_npp_20141101-20141130_00N060W_vcmcfg_v10_c201502231455.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201412/vcmcfg/SVDNB_npp_20141201-20141231_00N060W_vcmcfg_v10_c201502231125.tgz"
  )

Tile5_2015 <-
  c("https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201501/vcmcfg/SVDNB_npp_20150101-20150131_00N060W_vcmcfg_v10_c201505111709.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201502/vcmcfg/SVDNB_npp_20150201-20150228_00N060W_vcmcfg_v10_c201504281504.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201503/vcmcfg/SVDNB_npp_20150301-20150331_00N060W_vcmcfg_v10_c201505191916.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201504/vcmcfg/SVDNB_npp_20150401-20150430_00N060W_vcmcfg_v10_c201506011707.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201505/vcmcfg/SVDNB_npp_20150501-20150531_00N060W_vcmcfg_v10_c201506161325.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201506/vcmcfg/SVDNB_npp_20150601-20150630_00N060W_vcmcfg_v10_c201508141522.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201507/vcmcfg/SVDNB_npp_20150701-20150731_00N060W_vcmcfg_v10_c201509151839.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201508/vcmcfg/SVDNB_npp_20150801-20150831_00N060W_vcmcfg_v10_c201509301759.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201509/vcmcfg/SVDNB_npp_20150901-20150930_00N060W_vcmcfg_v10_c201511121210.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201510/vcmcfg/SVDNB_npp_20151001-20151031_00N060W_vcmcfg_v10_c201511181404.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201511/vcmcfg/SVDNB_npp_20151101-20151130_00N060W_vcmcfg_v10_c201512121648.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201512/vcmcfg/SVDNB_npp_20151201-20151231_00N060W_vcmcfg_v10_c201601251413.tgz"
  )


Tile5_2016 <-
  c("https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201601/vcmcfg/SVDNB_npp_20160101-20160131_00N060W_vcmcfg_v10_c201603132032.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201602/vcmcfg/SVDNB_npp_20160201-20160229_00N060W_vcmcfg_v10_c201603152010.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201603/vcmcfg/SVDNB_npp_20160301-20160331_00N060W_vcmcfg_v10_c201604191144.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201604/vcmcfg/SVDNB_npp_20160401-20160430_00N060W_vcmcfg_v10_c201606140957.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201605/vcmcfg/SVDNB_npp_20160501-20160531_00N060W_vcmcfg_v10_c201606281430.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201606/vcmcfg/SVDNB_npp_20160601-20160630_00N060W_vcmcfg_v10_c201608101832.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201607/vcmcfg/SVDNB_npp_20160701-20160731_00N060W_vcmcfg_v10_c201609121310.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201608/vcmcfg/SVDNB_npp_20160801-20160831_00N060W_vcmcfg_v10_c201610041107.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201609/vcmcfg/SVDNB_npp_20160901-20160930_00N060W_vcmcfg_v10_c201610280941.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201610/vcmcfg/SVDNB_npp_20161001-20161031_00N060W_vcmcfg_v10_c201612011122.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201611/vcmcfg/SVDNB_npp_20161101-20161130_00N060W_vcmcfg_v10_c201612191231.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201612/vcmcfg/SVDNB_npp_20161201-20161231_00N060W_vcmcfg_v10_c201701271136.tgz"
  )

Tile5_2017 <-
  c("https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201701/vcmcfg/SVDNB_npp_20170101-20170131_00N060W_vcmcfg_v10_c201702241223.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201702/vcmcfg/SVDNB_npp_20170201-20170228_00N060W_vcmcfg_v10_c201703012030.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201703/vcmcfg/SVDNB_npp_20170301-20170331_00N060W_vcmcfg_v10_c201705020851.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201704/vcmcfg/SVDNB_npp_20170401-20170430_00N060W_vcmcfg_v10_c201705011300.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201705/vcmcfg/SVDNB_npp_20170501-20170531_00N060W_vcmcfg_v10_c201706021500.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201706/vcmcfg/SVDNB_npp_20170601-20170630_00N060W_vcmcfg_v10_c201707021700.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201707/vcmcfg/SVDNB_npp_20170701-20170731_00N060W_vcmcfg_v10_c201708061230.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201708/vcmcfg/SVDNB_npp_20170801-20170831_00N060W_vcmcfg_v10_c201709051000.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201709/vcmcfg/SVDNB_npp_20170901-20170930_00N060W_vcmcfg_v10_c201710041620.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201710/vcmcfg/SVDNB_npp_20171001-20171031_00N060W_vcmcfg_v10_c201711021230.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201711/vcmcfg/SVDNB_npp_20171101-20171130_00N060W_vcmcfg_v10_c201712040930.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201712/vcmcfg/SVDNB_npp_20171201-20171231_00N060W_vcmcfg_v10_c201801021747.tgz"
  )

Tile5_2018 <-
  c("https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201801/vcmcfg/SVDNB_npp_20180101-20180131_00N060W_vcmcfg_v10_c201805221252.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201802/vcmcfg/SVDNB_npp_20180201-20180228_00N060W_vcmcfg_v10_c201803012000.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201803/vcmcfg/SVDNB_npp_20180301-20180331_00N060W_vcmcfg_v10_c201804022005.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201804/vcmcfg/SVDNB_npp_20180401-20180430_00N060W_vcmcfg_v10_c201805021400.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201805/vcmcfg/SVDNB_npp_20180501-20180531_00N060W_vcmcfg_v10_c201806061100.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201806/vcmcfg/SVDNB_npp_20180601-20180630_00N060W_vcmcfg_v10_c201904251200.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201807/vcmcfg/SVDNB_npp_20180701-20180731_00N060W_vcmcfg_v10_c201812111300.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201808/vcmcfg/SVDNB_npp_20180801-20180831_00N060W_vcmcfg_v10_c201809070900.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201809/vcmcfg/SVDNB_npp_20180901-20180930_00N060W_vcmcfg_v10_c201810250900.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201810/vcmcfg/SVDNB_npp_20181001-20181031_00N060W_vcmcfg_v10_c201811131000.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201811/vcmcfg/SVDNB_npp_20181101-20181130_00N060W_vcmcfg_v10_c201812081230.tgz",
    "https://eogdata.mines.edu/wwwdata/viirs_products/dnb_composites/v10//201812/vcmcfg/SVDNB_npp_20181201-20181231_00N060W_vcmcfg_v10_c201902122100.tgz"
  )

# Specify the names of all your tiles and years
#all_tiles <- c('Tile2_2015', 'Tile5_2015')

# Get the list of all named variables in the environment
all_tiles <- ls()


print("Got all the years!") # debugging
print(all_tiles) # debugging


############## Create the folders to store the images in
# All our images will be in the output_folder folder.

output_folder <- "./NLData"

if (file.exists("NLData") == FALSE) {
  dir.create(output_folder)
}

# TempData is where we'll store the unzipped files. These are deleted after
### each iteration. If all goes well, this will be empty after completion
dir.create(paste0(output_folder,"/TempData"))

print("Starting the process!") # debugging

for (tile in all_tiles) {
  
  print(paste0("We are working on tile: ", tile)) # debugging
  
  tile_number <- substr(tile, 1,5) # Get the appropriate tile
  
  print(paste0("We're working on: ", tile)) # debugging
  
  ## Check to see if there is already a folder labeled with the year
  if (file.exists(paste0(output_folder, "/", tile_number)) == FALSE) {
    ## If not, create the folder
    dir.create(paste0(output_folder, "/", tile_number))
  }
  
  output_location <- paste0(output_folder, "/", tile_number)
  
  # We need to use get() here since we used a string for the variable name
  for (url in get(tile)) { 
    
    # Folder to store all the raw files
    store_folder <- paste0(output_folder,"/TempData/")
    
    print(paste0("We're working on: ", tile)) # debugging
    
    # Create the temporary name for the downloaded .tgz file 
    temp_name <- "temp.tgz"
    
    # Download the file into the specified folder
    download.file(url, paste0(store_folder, temp_name))
    
    # Obtain file name we want
    unzipped <- untar(paste0(store_folder, temp_name),list=TRUE) 
    untar(paste0(store_folder, temp_name), files = unzipped[1],
          exdir = output_location)
    
    # Clear TGZ folder since we no longer need them anymore
    file.remove(list.files(store_folder, full.names = TRUE))
    
    print(paste0("Done with: ", url)) # debugging
  }
  
  # Print completion of the year
  print(paste0("Done with: ", tile_number)) # debugging
}
