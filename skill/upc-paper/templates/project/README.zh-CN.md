# UPC 论文工程 —— 多文件骨架

[English](README.md) | **中文**

这是一篇能跑的论文，不是空模板：能编译、通过检查，还带着一份完整的示例论文
（压力壳泄压问题），里面的数字都由 `code/` 里的代码算出。换掉内容、保留结构即可。

## 快速开始

```bash
bash scripts/build.sh main.tex                     # 编译 + 日志检查
python3 scripts/check_pdf.py main.pdf --team 000 --problem A
python3 scripts/count_summary.py main.tex --tex     # 摘要词数
python3 code/blowdown.py                            # 复现正文里的数字
python3 scripts/make_example_fig.py                 # 重新生成示例图
```

从模板复制出来的新工程，要把输出改成交稿文件名：

```bash
cp main.pdf 000A.pdf        # <队号><题号>.pdf，如 778A.pdf
```

`make` 把前三条命令包在一起，`make pdf` 直接生成 `000A.pdf`；见 `Makefile`。

## 文件地图

| 路径 | 是什么 | 谁来改 |
|---|---|---|
| `config.tex` | 队号、题号、标题——就三行，别的都不放 | 只有队长 |
| `preamble.tex` | 宏包、版面、页眉页脚、符号宏 | 只有队长 |
| `main.tex` | `\input` 顺序、参考文献 | 只有队长 |
| `sections/00-frontmatter.tex` | 第 1 页：规则允许的四项 + 摘要 | 队长 |
| `sections/01-introduction.tex` … `09-conclusion.tex` | 正文，一节一个文件 | 各节负责人 |
| `sections/10-appendix.tex` | 推导、代码清单、扫描表 | 建模负责人 |
| `sections/11-ai-report.tex` | AI 使用报告，需要时才打开 | 队长 |
| `refs.bib` | 只放真读过的文献，每条都要核对 | 任何人，走 PR/commit |
| `figures/` | 矢量 PDF，由 `scripts/` 生成 | 图表负责人 |
| `code/` | 附录里引用的代码 | 建模负责人 |
| `notes/` | 草稿区：推导、数据笔记、会议记录 | 任何人 |

## 骨架强制了什么

- **第 1 页**只有队号、题号、标题和摘要（`00-frontmatter.tex` 是 `titlepage`，
  之后页码复位为 2）。
- **每页页眉都有队号**，包括标题页和附录（`fancyhdr` 重定义了 `plain`，不是默认样式）。
- **不出现姓名、学校、致谢**——任何能识别队伍的信息，规则里都直接取消资格。
- **按引用顺序编号的数字引用**（`natbib`、`unsrt`），`[1]` 就是正文第一次引用的那篇。
- **代码放附录、方法留正文**——`\lstinputlisting` 直接引入 `code/blowdown.py`，
  清单不会和实际跑的代码脱节。
- **摘要要数字数**：这份示例 200 词，上限 300。

## 多人协作

1. 队长把这个目录复制成 `<队号><题号>/`（或者直接跑 `../scripts/new_paper.sh`），
   填 `config.tex`，提交。
2. 每个人只改自己的 `sections/*.tex` 和 `figures/*.pdf`。中途别碰 `preamble.tex`，
   要改先跟队长说：它一动，所有人都得重编。
3. 每次提交前先编译。`scripts/build.sh` 遇到未定义引用、缺图就失败，构建报错没有
   歧义。
4. 会出现在多处（摘要、结果、结论）的数字只留一个来源：写进 `notes/numbers.md`
   再复制，或者在 `config.tex` 里定义成宏。摘要和结论对不上，是最常见的自伤扣分。

## 示例论文，以及为什么值得留着

示例题是压力壳破裂：628 m³ 的舱体通过一个圆孔，多久掉到 0.3 p₀。选它是因为它把
骨架的每一部分都用上了——分层模型、一个校准参数、一条标度律、一份误差预算，以及
由产出表格的同一份代码画出的图。正文里的数字不是装饰：`code/blowdown.py` 在
d = 10 cm 时打印 285.5 s，论文写 286 s，按不确定度取整。

换成你自己的内容：

1. 删掉 `sections/01`–`09` 的正文，保留 `%% GUIDE` 注释。
2. 保留 `03-assumptions.tex` 的结构（每条假设一行，附一个定量检查）——这是多数
   队伍写得最薄的一节。
3. 把 `\includegraphics` 指向你自己的图，删掉 `figures/example.pdf` 和
   `code/blowdown.py`，并更新 `10-appendix.tex`。
4. 把 `refs.bib` 换成你真正读过的文献。

## 骨架已知的局限

- 单栏、US Letter、12 pt——74 篇金牌论文里的多数选择，但有 18 篇是双栏。在
  `preamble.tex` 里改（文件底部的注释块写了版面要怎么动）。
- `listings` 用的是朴素样式；代码行太长时，在 `\lstset` 块里设 `breaklines=true`，
  别缩字号。
- `natbib` 数字模式：要作者—年份的话，`preamble.tex` 里的两个选项和 `main.tex`
  里的 `\bibliographystyle` 要一起改。
