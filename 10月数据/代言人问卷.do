 import excel "C:\Users\admin\Documents\WXWork\1688857375571881\Cache\File\2024-09\R1+R2-1_Data_0919v1.xlsx", sheet( "TTLData_stata") firstrow case(lower) clear

browse
drop if coofandy_awareness !="Yes, it is a men's fashion brand."
encode gender, gen(gen_)
encode age, gen(age_)
encode education, gen(edu_)
encode marital, gen(marit_)
encode annualhousehold, gen(income_)
encode habit_fb, gen(use_fb)
encode habit_ins, gen(use_ins)
encode habit_x, gen(use_x)
encode habit_sc, gen(use_sc)
encode habit_tt, gen(use_tt)
encode habit_yt, gen(use_yt)
encode habit_p, gen(use_p)

*描述: 触达人群为高等学历已婚35-44中年中高收入男性，居住在NY、亚特兰大州 ，职业可能为工程技术人员（IT..),金融工作者或制造业工人。习惯在亚马逊购物，自己为服装购物首要决策者。日常社媒习惯使用Ins,facebook和youtube。对时尚模特、电视剧或运动内容感兴趣。最喜欢的明星可能是Cristiano Ronaldo、JUSTIN BIEBER或messi。

graph hbar (count) respondentid, over (occupation) blabel (bar, position(outside))
graph hbar (count) respondentid, over (education) blabel (bar, position(outside))
graph hbar (count) respondentid, over (marital) blabel (bar, position(outside))
graph hbar (count) respondentid, over (annualhousehold) blabel (bar, position(outside))
graph hbar (count) respondentid, over (age_) blabel (bar, position(outside))
graph hbar (count) respondentid, over (state) blabel (bar, position(outside))
graph hbar (count) respondentid, over (odd_majorusregion) blabel (bar, position(outside))
graph hbar (count) respondentid, over (buying_channel) blabel (bar, position(outside))
graph hbar (count) respondentid, over (buying_role) blabel (bar, position(outside))
sum use_fb use_ins use_x use_sc use_tt use_yt use_p
tabulate celebrity
sum 
describe gender
label list
*coofandy认知渠道： 主要是社媒（FACEBOOK和ins)，其次是购物平台， 第三是搜索引擎。
*stylish和high quality是对coofandy最主要的印象。其次是comfortable和affordable。
*代言人影响差异：raf的点击优于sean, sean的互动优于raf
tab gender 
tab raf_search 
tab sean_search
tabulate raf_search  sean_search
sum sean_search
graph hbox raf_click sean_click raf_engage sean_engage  raf_visit sean_visit 
graph hbox raf_search sean_search   raf_follow   sean_follow raf_buy sean_buy

asdoc reg raf_search i.age_
*搜索兴趣和年龄无显著相关
asdoc reg raf_click i.age_
*点击兴趣和年龄无显著相关
asdoc reg raf_engage i.age_
asdoc reg raf_buy i.age_
asdoc reg raf_search i.gen_
*和性别无显著相关
asdoc reg raf_buy i.income_
*家庭年收入$50,000 to $74,999段的和购买意向呈现显著负相关。这个收入段的消费者更不愿意因为raf而购买。

asdoc reg sean_buy i.income_
*家庭年收入在$75,000 to $99,999的消费者购买医院呈现显著负相关。这个收入段的更不愿意因为raf而购买。
*影响因素:收入水平。 收入水平越低，越可能不知道raf/ sean。
*         受教育水平。 Master degree更有可能知道sean。

encode raf_awa,gen(know_ref)
encode sean_awa, gen(know_sean)
asdoc reg know_ref i.income_
asdoc reg know_sean i.income_
asdoc reg know_ref i.edu_
asdoc reg know_sean i.edu_

*非正态，方差不齐,采用非参数检验
swilk raf_buy
swilk sean_buy
qnorm raf_buy
qnorm sean_buy
tabstat raf_buy, stat(count mean sd var q)
tabstat sean_buy, stat(count mean sd var q)
robvar raf_buy,by(income_)
robvar sean_buy, by(income_)
kwallis raf_buy,by(income_)
*p>0.001, 中位数相等，差异不大