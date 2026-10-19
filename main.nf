process downloadTree {
    publishDir "results"

    output:
    path "ref.nw.gz"

    script:
    """
    wget -q https://booster.pasteur.fr/static/files/primates/ref.nw.gz
    """
}

process listTips {
    publishDir "results"

    input:
    path tree

    output:
    path "tips.tsv"

    script:
    """
    gotree stats tips -i ${tree} > tips.tsv
    """
}

workflow {
    tree = downloadTree()
    tips = listTips(tree)

    tips.view { "tips file: $it" }
    tipCount = tips.splitCsv(sep: '\t', header: true).count()
    tipCount.view { "number of tips: $it" }
}
