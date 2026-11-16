## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(eval = FALSE, collapse = TRUE, comment = "#>")

## ----example-1, eval=FALSE----------------------------------------------------
# install.packages("remotes")
# remotes::install_github("DangJem/ggchord", dependencies = NA)

## ----example-2, eval=FALSE----------------------------------------------------
# getRversion()
# packageVersion("ggplot2")
# packageVersion("ggchord")
# find.package("ggchord")

## ----example-3, eval=FALSE----------------------------------------------------
# library(ggchord)
# 
# p <- ggchord(seq_data_example) +
#   geom_seq() +
#   geom_seq_label() +
#   coord_chord()
# p

## ----example-4, eval=FALSE----------------------------------------------------
# library(ggchord)

## ----example-5, eval=FALSE----------------------------------------------------
# p_chord_backbone <- ggchord(seq_data = seq_data_example) +
#   geom_seq() +
#   geom_seq_label() +
#   coord_chord()
# view_ggchord(p_chord_backbone, width = 7, height = 7, units = "in")

## ----example-6, eval=FALSE----------------------------------------------------
# chord_links <- head(ribbon_data_example, 1)
# 
# p_chord_ribbon <- p_chord_backbone +
#   geom_link_ribbon(data = chord_links)
# view_ggchord(p_chord_ribbon, width = 7, height = 7, units = "in")

## ----example-7, eval=FALSE----------------------------------------------------
# chord_genes_example <- subset(gene_data_example, accver == "OQ646790.1" & start == 43765)
# chord_genes_example$strand <- chord_genes_example$source_strand
# 
# p_chord_feature <- p_chord_ribbon +
#   geom_gene(data = chord_genes_example)
# view_ggchord(p_chord_feature, width = 7, height = 7, units = "in")

## ----example-8, eval=FALSE----------------------------------------------------
# p_chord_gene_labels <- p_chord_feature +
#   geom_gene_label(data = chord_genes_example, label_radial_offset = 0.10)
# view_ggchord(p_chord_gene_labels, width = 7, height = 7, units = "in")

## ----example-9, eval=FALSE----------------------------------------------------
# p_chord_linear <- p_chord_gene_labels + coord_collinear()
# view_ggchord(p_chord_linear, width = 8, height = 5, units = "in")

## ----example-10, eval=FALSE---------------------------------------------------
# library(ggchord)

## ----example-11, eval=FALSE---------------------------------------------------
# library(dplyr)
# circle_seqs <- plasmid_example_pUC19 |> select(accver, length)
# circle_origins <- tibble(
#   accver = "pUC19", start = 867, end = 1455,
#   strand = "-", type = "rep_origin", anno = "ori"
# )
# p_coursecircle <- ggchord(circle_seqs) +
#   geom_seq() + geom_seq_center_label() + coord_circular()

## ----example-12, eval=FALSE---------------------------------------------------
# p_coursecirclefeature <- p_coursecircle +
#   geom_feature_plasmid(data = circle_origins) +
#   geom_feature_label(data = circle_origins,
#     label_side = "inside", label_radial_offset = 0.12, size = 4)
# view_ggchord(p_coursecirclefeature, width = 10, height = 8, units = "in")

## ----example-13, eval=FALSE---------------------------------------------------
# circular_width <- 10
# circular_height <- 8
# view_ggchord(p_coursecirclefeature,
#   width = circular_width, height = circular_height, units = "in")
# ggsave("circular-first.png", p_coursecirclefeature,
#   width = circular_width, height = circular_height, units = "in", dpi = 144)

## ----example-14, eval=FALSE---------------------------------------------------
# library(ggchord)
# library(dplyr)

## ----example-15, eval=FALSE---------------------------------------------------
# library(dplyr)
# dotplot_hsp <- sequence_detail_example$paf
# dotplot_seqs <- bind_rows(
#   dotplot_hsp |> transmute(accver = qaccver, length = qlen),
#   dotplot_hsp |> transmute(accver = saccver, length = slen)
# ) |>
#   distinct()

## ----example-16, eval=FALSE---------------------------------------------------
# p_viewdotplot <- ggchord(dotplot_seqs, dotplot_hsp) +
#   geom_alignment_segment(aes(link_colour = pident), linewidth = 0.65) +
#   coord_dotplot()
# view_ggchord(p_viewdotplot, width = 8, height = 7, units = "in")

## ----example-17, eval=FALSE---------------------------------------------------
# dotplot_reversed <- ggchord(dotplot_seqs, dotplot_hsp) +
#   geom_alignment_segment(aes(link_colour = pident), linewidth = 0.65) +
#   coord_dotplot(y_orientation = -1)
# dotplot_layout <- export_ggchord_layout(dotplot_reversed)
# dotplot_layout$axis_layout

## ----example-18, eval=FALSE---------------------------------------------------
# library(ggchord)
# library(dplyr)
# flagship_paper <- "#FFFCF5"
# flagship_sequences <- flagship_dotplot_example$seq_data
# flagship_hsp <- flagship_dotplot_example$links
# flagship_theme <- theme_ggchord_publication() +
#   theme(
#     plot.background = element_rect(fill = flagship_paper, colour = NA),
#     panel.background = element_rect(fill = flagship_paper, colour = NA),
#     legend.background = element_rect(fill = flagship_paper, colour = NA),
#     legend.key = element_rect(fill = flagship_paper, colour = NA),
#     legend.position = "right", legend.box = "vertical", legend.text = element_text(size = 8),
#     legend.title = element_text(size = 9),
#     plot.margin = margin(12, 16, 12, 16)
#   )

## ----example-19, eval=FALSE---------------------------------------------------
# dotplot_pair_counts <- flagship_dotplot_example$pair_counts
# dotplot_cells <- flagship_dotplot_example$cell_labels
# flag_dotplot <- ggchord(flagship_sequences, flagship_hsp) +
#   geom_alignment_segment(aes(link_colour = pident, link_linewidth = length), alpha = 0.85) +
#   scale_link_linewidth_continuous(range = c(0.8, 1.8), name = "HSP length (bp)") +
#   coord_dotplot(x_seqs = flagship_sequences$accver, y_seqs = flagship_sequences$accver,
#     gap = 4000) +
#   ggplot2::geom_text(data = dotplot_cells, aes(x = x, y = y, label = label),
#     inherit.aes = FALSE, hjust = 0, vjust = 1, size = 2.8, colour = "#566E67") +
#   labs(title = "Six observed sequence pairs · 32 HSPs",
#     subtitle = "One query→subject direction per pair; empty cells contain no input records") +
#   flagship_theme +
#   theme(
#     panel.grid = element_blank(), legend.position = "bottom", legend.box = "horizontal",
#     axis.text = element_text(size = 9),
#     axis.text.x.top = element_text(size = 10, face = "bold", margin = margin(b = 9)),
#     axis.text.y.left = element_text(size = 10, face = "bold", margin = margin(r = 9)),
#     axis.text.y.right = element_text(size = 9),
#     axis.ticks.length = unit(1.5, "mm"),
#     plot.margin = margin(12, 16, 12, 16)
#   )

## ----example-20, eval=FALSE---------------------------------------------------
# hsp_direction <- flagship_hsp |>
#   mutate(relative_direction = if_else(
#     (qend - qstart) * (send - sstart) < 0, "reverse", "forward"
#   )) |>
#   count(qaccver, saccver, relative_direction, name = "HSP")
# hsp_direction

## ----example-21, eval=FALSE---------------------------------------------------
# map_ggchord_position(
#   flag_dotplot, flagship_hsp$qaccver[1], flagship_hsp$qstart[1], axis = "x"
# )

## ----example-22, eval=FALSE---------------------------------------------------
# library(ggchord)
# library(dplyr)

## ----example-23, eval=FALSE---------------------------------------------------
# library(dplyr)
# fusion_hsp <- sequence_detail_example$paf
# fusion_seqs <- bind_rows(
#   fusion_hsp |> transmute(accver = qaccver, length = qlen),
#   fusion_hsp |> transmute(accver = saccver, length = slen)
# ) |>
#   distinct()
# fusion_colours <- setNames(c("#0072B2", "#D55E00"), fusion_seqs$accver)
# fusion_links <- fusion_hsp |>
#   filter(length >= 900, pident >= 85)
# fusion_events <- fusion_hsp |>
#   transmute(accver = qaccver, pos = qstart)

## ----example-24, eval=FALSE---------------------------------------------------
# course_center <- ggchord(fusion_seqs |> slice(1)) +
#   geom_seq(show.legend = FALSE) +
#   coord_circular()
# course_detail <- ggchord(fusion_seqs) +
#   geom_seq(show.legend = FALSE) +
#   geom_seq_label() +
#   coord_collinear(seq_axis = "vertical")
# p_coursefusion <- ggchord_fusion(course_center) +
#   fusion_panel(course_detail, id = "detail", side = "right") +
#   fusion_ribbon(
#     fusion_links |> slice(1), qpanel = "center", spanel = "detail",
#     fill = "#269B82", alpha = 0.35
#   )
# view_ggchord(p_coursefusion, width = 12, height = 8, units = "in")

## ----example-25, eval=FALSE---------------------------------------------------
# fusion_width <- 12
# fusion_height <- 8
# view_ggchord(p_coursefusion,
#   width = fusion_width, height = fusion_height, units = "in")
# course_export <- export_ggchord_fusion(p_coursefusion,
#   width = fusion_width, height = fusion_height)
# course_export$connections
# course_export$fronts

## ----example-26, eval=FALSE---------------------------------------------------
# ggsave("fusion-first.png", p_coursefusion,
#   width = fusion_width, height = fusion_height, units = "in", dpi = 144)

## ----example-27, eval=FALSE---------------------------------------------------
# ggchord(seq_data_example, ribbon_data_example) +
#   geom_alignment_segment(aes(link_colour = pident)) +
#   coord_dotplot()
# 
# ggchord(seq_data_example, ribbon_data_example) +
#   geom_seq() +
#   geom_link_ribbon() +
#   geom_seq_label() +
#   coord_radial_synteny()

