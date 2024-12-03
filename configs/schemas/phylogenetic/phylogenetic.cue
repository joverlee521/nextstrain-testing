package phylogenetic

// CUE syntax
// ? = optional fields
// close = can only have fields permitted by this struct
filter: close({
  // metadata filters
  query?: string
  query_columns?: string
  min_date?: string
  max_date?: string
  exclude_ambiguous_dates_by?: string
  exclude?: string
  exclude_where?: string
  include?: string
  include_where?: string
  // sequence filters
  min_length?: number
  max_length?: number
  non_nucleotide?: bool
})
