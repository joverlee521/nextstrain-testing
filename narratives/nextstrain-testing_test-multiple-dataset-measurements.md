---
title: Test narrative which renders multiple datasets with measurements sidecars
date: "2022-11-29"
dataset: "https://nextstrain.org/community/blab/measurements-panel/flu/seasonal/h3n2/ha"
---


# [Dataset 1 w/ measurements](https://nextstrain.org/community/blab/measurements-panel/flu/seasonal/h3n2/ha?m_overallMean=hide)

Dataset 1 with measurements sidecar JSON (same dataset as title page).


# [Dataset 2 w/ measurements ](https://nextstrain.org/community/joverlee521/nextstrain-testing/flu/seasonal/h1n1pdm/ha/09-17?m_collection=egg_HI_raw&m_overallMean=show&m_display=raw)

Dataset 2 with measurements sidecar JSON.
Changes dataset _and_ has additional URL query params for the measurements panel to show overall mean and use raw display.

# [Dataset 2 w/ measurements ](https://nextstrain.org/community/joverlee521/nextstrain-testing/flu/seasonal/h1n1pdm/ha/09-17)

Dataset 2 with measurements sidecar JSON (same as previous slide).

# [Dataset 2 w/ different collection](https://nextstrain.org/community/joverlee521/nextstrain-testing/flu/seasonal/h1n1pdm/ha/09-17?d=measurements&m_collection=egg_HI_raw)

Dataset 2 with only the measurements panel.
This should be displaying the "Egg Passaged" collection that is different than the default "Cell Passaged" collection.

# [Hide overall mean](https://nextstrain.org/community/joverlee521/nextstrain-testing/flu/seasonal/h1n1pdm/ha/09-17?d=measurements&m_overallMean=hide)

This should revert back to the default "Cell Passaged" collection, but hide the overall means per row.

# [Display raw and change coloring](https://nextstrain.org/community/joverlee521/nextstrain-testing/flu/seasonal/h1n1pdm/ha/09-17?c=region&d=measurements&m_display=raw)

Changing to raw displays and changing coloring at the same time to see if we run
into the bug from changing multiple states in D3.

# [Hide threshold](https://nextstrain.org/community/joverlee521/nextstrain-testing/flu/seasonal/h1n1pdm/ha/09-17?d=measurements&m_threshold=hide)

This should hide the thresholds.

# [Different group by](https://nextstrain.org/community/joverlee521/nextstrain-testing/flu/seasonal/h1n1pdm/ha/09-17?d=measurements&m_groupBy=serum)

This should display a different grouping by serum instead of the default reference strains.

# [Filter to different reference strains](https://nextstrain.org/community/joverlee521/nextstrain-testing/flu/seasonal/h1n1pdm/ha/09-17?d=measurements&mf_reference_strain=A/Astrakhan/1/2011)

This should display measurements panel filtered to only the `A/Astrakhan/1/2011` reference strain.

# [Filter to different reference strains](https://nextstrain.org/community/joverlee521/nextstrain-testing/flu/seasonal/h1n1pdm/ha/09-17?d=measurements&mf_reference_strain=A/Astrakhan/1/2011&mf_reference_strain=A/Bayern/69/2009)

This should display measurements panel filtered to two reference strains.

# [Color tree by measurements](https://nextstrain.org/community/joverlee521/nextstrain-testing/flu/seasonal/h1n1pdm/ha/09-17?d=tree,measurements&c=m-A/Astrakhan/1/2011&p=grid)

This should color tree by measurements (`A/Astrakhan/1/2011`)

# [Filter to different reference strains with measurements coloring](https://nextstrain.org/community/joverlee521/nextstrain-testing/flu/seasonal/h1n1pdm/ha/09-17?d=tree,measurements&mf_reference_strain=A/Astrakhan/1/2011&mf_reference_strain=A/HongKong/90/2016&c=m-A/HongKong/90/2016&p=grid)

This should display measurements panel filtered to 2 reference strains
and color tree by measurements (`A/HongKong/90/2016`).

# [Filter to one reference strain with measurements coloring](https://nextstrain.org/community/joverlee521/nextstrain-testing/flu/seasonal/h1n1pdm/ha/09-17?d=tree,measurements&mf_reference_strain=A/Bayern/69/2009&c=m-A/Astrakhan/1/2011&p=grid)

This should display measurements panel filtered to 1 reference strain and color
tree by measurements (`A/Astrakhan/1/2011`). Because `A/Astrakhan/1/2011` is not
included in the measurements data, the coloring is all grey.
