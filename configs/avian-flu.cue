import "nextstrain.org/schemas/phylogenetic"

#segment: "pb2" | "pb1" | "pa" | "ha" | "np" | "na" | "mp" | "ns"

#subtypes: ({[string]: [string, ...string]}) |
  *{
    "h5nx": ["all-time", "2y"],
    "h5n1": ["all-time", "2y"],
    "h7n9": ["all-time"],
    "h9n2": ["all-time"],
  }

#segments: [#segment, ...#segment] |
  *["pb2", "pb1", "pa", "ha", "np", "na", "mp", "ns"]

#min_length: ({[#segment]: number}) |
  *{
    "pb2": 2100,
    "pb1": 2100,
    "pa": 2000,
    "ha": 1600,
    "np": 1400,
    "na": 1270,
    "mp": 900,
    "ns": 800,
  }

#min_date: ({[string]: [string]: string}) |
  *{
    h5nx: {
      "all-time": "1996",
      "2y": "2Y"
    },
    h5n1: {
      "all-time": "1996",
      "2y": "2Y"
    },
    h7n9: {
      "all-time": "2013",
    },
    h9n2: {
      "all-time": "1966",
    },
  }

builds: {
  for subtype, resolutions in #subtypes
  for segment in #segments
  for resolution in resolutions
  {
    "\(subtype)" : "\(segment)": "\(resolution)": {
      filter: phylogenetic.filter & close({
        min_length: #min_length[segment],
        min_date: #min_date[subtype][resolution]
      })
    }
  }
}

custom_param?: string
