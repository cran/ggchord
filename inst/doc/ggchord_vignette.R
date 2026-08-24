## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  warning = FALSE,
  message = FALSE,
  fig.width = 8,
  fig.height = 7,
  fig.align = "center",
  out.width = "100%"
)

## ----library------------------------------------------------------------------
library(ggchord)
library(ggplot2)

data(seq_data_example)
data(ribbon_data_example)
data(gene_data_example)

## ----import-helpers, eval=FALSE-----------------------------------------------
# library(ggchord)
# 
# # FASTA -> seq_data (read and combine all example FASTA files)
# seq_data <- invisible(read_fasta_lengths(files = "examples/fasta/*.fna"))
# 
# # BLAST -outfmt 6/7 tabular output -> ribbon_data (12 or 17 columns auto-detected)
# ribbon_data <- invisible(read_blast(files = "examples/blastn/*.o7"))
# 
# # GFF3 -> gene_data (CDS features by default; anno from product/Name/...)
# gene_data <- invisible(read_gff3(files = "examples/gff3/*.gff3"))
# 
# ggchord(seq_data, ribbon_data, gene_data) +
#   geom_seq() + geom_ribbon() + geom_gene()

## ----validate-clean, eval=FALSE-----------------------------------------------
# data(seq_data_example)
# data(ribbon_data_example)
# data(gene_data_example)
# 
# validate_ggchord_data(seq_data_example, ribbon_data_example, gene_data_example)
# 
# clean_ggchord_data(seq_data_example, ribbon_data_example, gene_data_example,
#                    unknown_id = "drop", out_of_range = "clip",
#                    reversed_interval = "sort", invalid_pident = "clip")

## ----ribbon-tidy, eval=FALSE--------------------------------------------------
# kept <- filter_ggchord_ribbons(ribbon_data_example, min_pident = 90,
#                                drop_self_links = TRUE,
#                                sort_by = "pident")
# dedup <- deduplicate_ggchord_ribbons(kept$data, by = "exact",
#                                      keep = "best_pident")
# merged <- merge_ggchord_ribbons(dedup$data, max_gap = 0)

## ----tutorial-seq, eval=FALSE-------------------------------------------------
# ggchord(seq_data_example) +
#   geom_seq()

## ----tutorial-seq-img, echo=FALSE, fig.cap="Sequence arcs."-------------------
knitr::include_graphics("../man/figures/seq_only_default.png")

## ----tutorial-ribbon, eval=FALSE----------------------------------------------
# ggchord(seq_data_example, ribbon_data_example) +
#   geom_seq() + geom_ribbon()

## ----tutorial-ribbon-img, echo=FALSE, fig.cap="Ribbons coloured by percent identity."----
knitr::include_graphics("../man/figures/ribbon_pident.png")

## ----tutorial-gene, eval=FALSE------------------------------------------------
# ggchord(seq_data_example, gene_data = gene_data_example) +
#   geom_seq() + geom_gene() + geom_gene_label_repel()

## ----tutorial-gene-img, echo=FALSE, fig.cap="Gene arrows with repelled labels."----
knitr::include_graphics("../man/figures/gene_repel.png")

## ----tutorial-axis, eval=FALSE------------------------------------------------
# ggchord(seq_data_example) +
#   geom_seq() + geom_axis() + geom_seq_label()

## ----tutorial-axis-img, echo=FALSE, fig.cap="Axes and sequence labels."-------
knitr::include_graphics("../man/figures/axis_seq_label.png")

## ----tutorial-group, eval=FALSE-----------------------------------------------
# seq_grouped <- transform(seq_data_example,
#                          seq_group = c("host", "host", "phage", "phage"))
# 
# ggchord(seq_grouped, ribbon_data_example, gene_data_example) +
#   geom_seq(seq_group = "seq_group",
#            seq_group_colors = c(host = "#E41A1C", phage = "#377EB8")) +
#   geom_ribbon() + geom_gene()

## ----tutorial-group-img, echo=FALSE, fig.cap="Sequences grouped with an inter-group gap and labels."----
knitr::include_graphics("../man/figures/tutorial_seq_group.png")

## ----tutorial-ribbon-map, eval=FALSE------------------------------------------
# rb_scored <- transform(ribbon_data_example,
#                        bitscore = seq_len(nrow(ribbon_data_example)) * 10)
# 
# ggchord(seq_data_example, rb_scored) +
#   geom_seq() +
#   geom_ribbon(ribbon_color_by = "bitscore",
#               ribbon_alpha_by = "bitscore",
#               ribbon_direction = "linetype")

## ----tutorial-ribbon-map-img, echo=FALSE, fig.cap="Continuous ribbon fill, alpha and direction mapping."----
knitr::include_graphics("../man/figures/tutorial_ribbon_mapping.png")

## ----tutorial-highlight, eval=FALSE-------------------------------------------
# regions <- data.frame(seq_id = "MT108731.1",
#                       start = 1000, end = 4000, color = "orange")
# 
# ggchord(seq_data_example, ribbon_data_example) +
#   geom_seq() + geom_ribbon() +
#   geom_seq_region(regions = regions) +
#   geom_ribbon_highlight(ribbon_ids = 1)

## ----tutorial-highlight-img, echo=FALSE, fig.cap="Sequence regions and ribbon highlight."----
knitr::include_graphics("../man/figures/tutorial_highlights.png")

## ----tutorial-feature, eval=FALSE---------------------------------------------
# features <- data.frame(seq_id = c("MT108731.1", "MT118296.1"),
#                        start = c(1000, 500), end = c(4000, 2000),
#                        strand = c("+", "-"), type = c("CDS", "tRNA"))
# 
# ggchord(seq_data_example, ribbon_data_example) +
#   geom_seq() + geom_ribbon() + geom_feature(features)

## ----tutorial-feature-img, echo=FALSE, fig.cap="Generic features drawn with geom_feature()."----
knitr::include_graphics("../man/figures/tutorial_features.png")

## ----tutorial-theme, eval=FALSE-----------------------------------------------
# ggchord(seq_data_example, ribbon_data_example, gene_data_example) +
#   geom_seq() + geom_ribbon() + geom_gene() + geom_axis() +
#   scale_color_manual(values = c("MT108731.1" = "#E41A1C",
#                                 "MT118296.1" = "#377EB8",
#                                 "OQ646790.1" = "#4DAF4A",
#                                 "OR222515.1" = "#984EA3")) +
#   theme(panel.background = element_rect(fill = "grey95"),
#         legend.position = "bottom", legend.box = "horizontal")

## ----tutorial-theme-img, echo=FALSE, fig.cap="A themed plot with all legends grouped."----
knitr::include_graphics("../man/figures/legend_bottom.png")

## ----tutorial-fine, eval=FALSE------------------------------------------------
# ggchord(seq_data_example, ribbon_data_example, gene_data_example,
#         title = "ggchord") +
#   geom_seq(seq_radius = c(3.3, 2.5, 1.8, 1.25),
#            seq_orientation = c(-1, -1, 1, -1),
#            seq_colors = c("MT108731.1" = "#E76F51",
#                           "MT118296.1" = "#264653",
#                           "OQ646790.1" = "#2A9D8F",
#                           "OR222515.1" = "#D9A62E")) +
#   geom_ribbon(ribbon_alpha = 0.45) +
#   geom_gene() +
#   geom_gene_label_repel(gene_label_size = 2, seed = 42) +
#   geom_seq_label() +
#   geom_axis() +
#   theme(plot.background = element_rect(fill = "#FBF9F6", colour = NA),
#         panel.background = element_rect(fill = "#FBF9F6", colour = NA))

## ----tutorial-fine-img, echo=FALSE, fig.cap="A complete fine-tuned chord diagram."----
knitr::include_graphics("../man/figures/combined_fine.png")

## ----flexible-formats, eval=FALSE---------------------------------------------
# # 1. One value for everything
# gene_label_rotation = 20
# 
# # 2. One value per strand, for every sequence
# gene_label_rotation = c("+" = -15, "-" = -45)
# 
# # 3. By sequence ID
# gene_label_rotation = list(
#   "MT118296.1" = c("+" = -15, "-" = -45),
#   "OR222515.1" = c("+" = 30, "-" = -30),
#   "MT108731.1" = c("+" = 15, "-" = -15),
#   "OQ646790.1" = c("+" = 0,  "-" = 0)
# )
# 
# # 4. By sequence order ("1" = first sequence)
# gene_label_rotation = list(
#   "1" = c("+" = -15, "-" = -45),
#   "2" = c("+" = 30, "-" = -30),
#   "3" = c("+" = 15, "-" = -15),
#   "4" = c("+" = 0,  "-" = 0)
# )
# 
# # 5. Unnamed list: follows the sequence order (same as #4)
# gene_label_rotation = list(
#   c("+" = -15, "-" = -45),
#   c("+" = 30, "-" = -30),
#   c("+" = 15, "-" = -15),
#   c("+" = 0,  "-" = 0)
# )
# 
# # 6. A length-one list recycles to every sequence
# gene_label_rotation = list(20)

