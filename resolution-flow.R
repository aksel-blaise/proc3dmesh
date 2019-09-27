library(DiagrammeR)

#diagram of flowchart for mesh resolution study
mermaid("graph LR

subgraph data collection
A((microCT)) -->|preprocess| C(Rvcg)
B((laser)) --> |preprocess| C(Rvcg)
end

subgraph processing
C --> D[u-remesh]
D --> E[decimation]
end

subgraph analysis
E -->|exportOFF| F(auto3dgm)
F -->|alOFF2PLY| G(digit3dland)
F --> |exportLM| H(geomorph)
G --> |exportLM| H
end
"
)