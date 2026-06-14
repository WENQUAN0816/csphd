# 计算机科学博士

本仓库整理了 2026-06-10 至 2026-06-11 对话中关于申请第二个计算机科学博士的判断、学校选择、学费预算、空间智能/世界模型研究方向、技术路线、数据集设计，以及更轻量的博士落地方案。

## 核心定位

建议申请方向不要写成泛泛的 "AI / computer vision / world model"，而是聚焦为：

> Multimodal Spatial World Models for Age-Friendly Built Environments: 3D Scene Understanding, Generative Layout Design, and Human-Centered Simulation

中文表述：

> 面向老龄友好建筑环境的多模态空间世界模型：三维场景理解、生成式布局设计与以人为本的空间仿真

这个方向把既有的室内设计、老龄友好环境、建筑空间评价研究经历，转化为计算机科学博士中的空间智能、计算机视觉、三维场景理解、视觉语言模型和生成式设计优化问题。

## 主要结论

- 申请第二个 CS/AI 博士是可行的，但必须解释清楚为什么不是继续做 postdoc，而是需要系统进入 CS 方法学训练。
- 自费录取的可能性明显高于奖学金成功率。第二博士会让奖学金难度显著增加。
- 最现实的学校组合是：USM、XMUM、Nottingham Malaysia 主申；Monash Malaysia 和 UM 作为冲刺。
- 最强的研究差异化不是 "我会 AI"，而是 "我能把老龄友好室内环境问题变成可计算、可预测、可生成的空间世界模型"。
- 核心数据集不应只是室内图片，而应包括空间几何、3D 视觉、家具物体、老龄友好标签、行为路径、改造建议和专家解释。
- 如果担心大规模数据采集过难，可以把博士方向降维为 "视觉语言模型 + 适老设计知识库 + 小规模专家验证" 的轻量空间智能框架。

## 文档结构

- [PhD Application Tracker](index.html) - 博士申请进度网站入口，使用 `phd_applications.json` 作为公开进度数据源。
- [01-申请学校与成功率.md](docs/01-申请学校与成功率.md)
- [02-学费预算.md](docs/02-学费预算.md)
- [03-空间智能与世界模型方向.md](docs/03-空间智能与世界模型方向.md)
- [04-技术栈与学习路线.md](docs/04-技术栈与学习路线.md)
- [05-数据集设计与标注规模.md](docs/05-数据集设计与标注规模.md)
- [06-下一步行动清单.md](docs/06-下一步行动清单.md)
- [07-轻量博士路线.md](docs/07-轻量博士路线.md)

## 博士申请进度网站

公开网站文件：

- `index.html` - 可筛选、可搜索、可查看详情的申请进度 dashboard。
- `phd_applications.json` - 公开安全版申请数据，不包含导师邮箱、Gmail message ID、证件、成绩单、护照、内部日志或私人文件路径。
- `scripts/generate_phd_status_site.ps1` - 从 `school_packages/` 和本地私有 outreach 记录重新生成公开 JSON。

本地更新数据：

```powershell
.\scripts\generate_phd_status_site.ps1
```

当前 tracker 区分了 `first_outreach_status` 和 `formal_application_status`：截至 2026-06-14，48 所目标院校的首轮导师套磁邮件均已发送；正式网申仍未递交，需要逐校登录申请系统、上传材料、确认真实性声明并处理可能的申请费。

## 正式网申状态

正式申请不是一封邮件，不能等同于导师套磁。正式网申通常需要：

- 创建或登录学校申请系统账号。
- 上传护照、学历证明、成绩单、英语成绩、CV、研究计划、作品集等文件。
- 填写推荐人、资金来源、签证/国籍、研究经历等表格。
- 勾选真实性/隐私/法律声明。
- 支付申请费或申请费减免。

正式申请执行清单见：

- [formal_application_submission_plan.md](formal_application_submission_plan.md)

## 一句话申请叙事

我的第一个博士建立了 age-friendly built environment / interior design 的领域问题和实证基础；第二个博士希望从 AI 应用进入计算机科学方法核心，研究能够理解、评估、预测并优化老龄友好室内环境的多模态空间世界模型。
