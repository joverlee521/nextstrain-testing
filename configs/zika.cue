import "nextstrain.org/schemas/phylogenetic"

filter: phylogenetic.filter & close({
  min_date: string | *"1950"
  min_length: number | *100000
})
