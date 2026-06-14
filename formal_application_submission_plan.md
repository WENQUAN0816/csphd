# 博士正式网申提交计划

更新日期：2026-06-14

## 当前结论

48 所目标院校已经完成首轮导师套磁邮件发送，但 48 所正式网申均尚未提交。

导师套磁邮件不等于正式申请。正式申请需要进入每所学校的网申系统，上传材料、填写表格、确认声明，并处理可能的申请费。

## 已完成

- 48 所学校均已有学校级申请包。
- 48 所学校均已有导师套磁状态记录。
- 48 所学校的首轮导师套磁邮件均已发送。
- 公开进度页已更新为 48 条 `First outreach sent`。
- 公开进度页仍保留 48 条 `Formal application: Not submitted`。

## 不能自动一键提交的原因

正式网申通常包含以下需要申请人本人确认的内容：

- 个人身份、国籍、签证、居住地等法律信息。
- 学历、成绩单、学位证、护照、照片等敏感文件上传。
- 推荐人姓名、邮箱和授权。
- 研究计划、资金来源、奖学金申请选项。
- 学校隐私政策、真实性声明、学术诚信声明。
- 申请费支付或申请费减免声明。

这些步骤不能在未逐项确认的情况下批量代提交。

## 推荐执行顺序

第一批优先正式网申：

1. Universiti Malaya
2. Universiti Sains Malaysia
3. Monash University Malaysia
4. Xiamen University Malaysia
5. University of Nottingham Malaysia
6. University of Waterloo
7. York University
8. City University of Hong Kong
9. HKU
10. HKUST

第二批：

1. Monash University
2. University of Melbourne
3. UNSW Sydney
4. University of Auckland
5. University of Waikato
6. UCL
7. University of Edinburgh
8. Aalto University
9. TU Delft
10. KTH Royal Institute of Technology

第三批：

- 其余学校根据导师回复、奖学金截止日期和申请费情况推进。

## 每所学校正式网申检查表

每所学校提交前至少确认：

- 申请入口 URL
- 项目名称和学院
- 入学季
- 申请截止日期
- 申请费
- 奖学金/助学金入口
- 目标导师是否需要预确认
- CV 文件
- 研究计划或 RCN 文件
- 作品集/AI-CS portfolio
- 护照
- 学位证明
- 成绩单
- 英语成绩或豁免说明
- 推荐人信息
- 是否需要研究计划导师确认信
- 是否需要支付申请费

## 状态字段规则

在 `phd_applications.json` 中：

- `first_outreach_status = Sent` 表示导师套磁已发。
- `formal_application_status = Not submitted` 表示学校网申尚未提交。
- 只有完成学校系统最终提交后，才能改为 `Submitted`。
- 如果只是创建账号或保存草稿，应记录为 `Draft started`，不能写成 `Submitted`。

