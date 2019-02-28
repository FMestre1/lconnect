# landmetrics
Simple tools to derive landscape connectivity metrics

The objective of this package is to provide the simplest possible approach to derive landscape connectivity metrics.

# These are the lanscape connectivity metrics provided:

##### Class coincidence probability #####
’CCP’ - Class coincidence probability. It is defined as the probability that two randomly chosen points within the habitat belong to the same component. Ranges between 0 and 1 (Pascual-Hortal and Saura 2006). Higher CCP implies higher connectivity. Threshold dependent (dispersal distance).

##### Landscape coincidence probability #####
’LCP’ - Landscape coincidence probability. It is defined as the probability that two randomly chosen points in the landscape (whether in an habitat patch or not) belong to the same habitat component. Ranges between 0 and 1 (Pascual-Hortal and Saura 2006). Threshold dependent (dispersal distance).

##### Characteristic path length #####
’CPL’ - Characteristic path length. Mean of all the shortest paths between the network nodes (patches) (Minor and Urban, 2008). The shorter the CPL value the more connected the patches are. Threshold dependent (dispersal distance).

##### Expected cluster size #####
’ECS’ - Expected cluster size. Mean cluster size of the clusters weighed by area. (O’ Brien et al.,2006 and Fall et al, 2007). This represents the size of the component in which a randomly located point in an habitat patch would reside. Although it is informative regarding the area of the component, it does not provide any ecologically meaningful information regarding the total area of habitat, as an example: ECS increases with less isolated small components or patches, although the total habitat decreases(Laita et al. 2011). Threshold dependent (dispersal distance).
 
 ##### Area-weighted flux #####
 ’AWF’ - Area-weighted Flux. Evaluates the flow, weighted by area, between all pairs of patches (Bunn et al. 2000 and Urban and Keitt 2001). The probability of dispersal between two patches (pij), required by the AWF formula, was computed using pij=exp(-k*dij), where k is a constant making pij=0.5 at half the dispersal distance defined by the user. Does not depend on any distance threshold (probabilistic).
 
##### Integral index of connectivity #####
’IIC’ - Integral index of connectivity. Index developed specifically for landscapes by PascualHortal and Saura (2006). It is based on habitat availability and on a binary connection model (as opposed to a probabilistic). It ranges from 0 to 1 (higher values indicating more connectivity). Threshold dependent (dispersal distance).

##### Probability of connectivity #####
’PC’ - Probability of connectivity. Probability that two points randomly placed in the landscape are in habitat patches that are connected, given the number of habitat patches and the connection probabilities (pij). Similar to IIC, although assuming probabilistic connections between patches (Saura and Pascual-Hortal 2007). Probability of inter-patch dispersal is computed in the same way as for AWF. Does not depend on any distance threshold (probabilistic).

##### Equivalent connected area #####
’ECA’ - The Equivalent Connected Area is the square root of the numerator in PC, not accounting for the total landscape area (AL) (Saura 2011a, 2011b). It is defined as ’...the size of a single habitat patch (maximally connected) that would provide the same value of the probability of connectivity than the actual habitat pattern in the landscape’ (Saura 2011a).

##### References #####
Bunn, A. G., Urban, D. L., and Keitt, T. H. (2000). Landscape connectivity: a conservation application of graph theory. Journal of Environmental Management, 59(4): 265-278.

Fall, A., Fortin, M. J., Manseau, M., and O’ Brien, D. (2007). Spatial graphs: principles and applications for habitat connectivity. Ecosystems, 10(3): 448-461.

Laita, A., Kotiaho, J.S., Monkkonen, M. (2011). Graph-theoretic connectivity measures: what do they tell us about connectivity? Landscape Ecology, 26: 951-967.

Minor, E. S., and Urban, D. L. (2008). A Graph-Theory Framework for Evaluating Landscape Connectivity and Conservation Planning. Conservation Biology, 22(2): 297-307.

O’Brien, D., Manseau, M., Fall, A., and Fortin, M. J. (2006). Testing the importance of spatial configuration of winter habitat for woodland caribou: an application of graph theory. Biological Conservation, 130(1): 70-83.

Pascual-Hortal, L., and Saura, S. (2006). Comparison and development of new graph-based landscape connectivity indices: towards the priorization of habitat patches and corridors for conservation. Landscape Ecology, 21(7): 959-967.

Saura, S., and Pascual-Hortal, L. (2007). A new habitat availability index to integrate connectivity in landscape conservation planning: comparison with existing indices and application to a case study. Landscape and Urban Planning, 83(2): 91-103.

Saura, S., Estreguil, C., Mouton, C. & Rodriguez-Freire, M. (2011a). Network analysis to assess landscape connectivity trends: application to European forests (1990-2000). Ecological Indicators 11: 407-416.

Saura, S., Gonzalez-Avila, S. & Elena-Rossello, R. (2011b). Evaluacion de los cambios en la conectividad de los bosques: el indice del area conexa equivalente y su aplicacion a los bosques de Castilla y Leon. Montes, Revista de Ambito Forestal 106: 15-21.

Urban, D., and Keitt, T. (2001). Landscape connectivity: a graph-theoretic perspective. Ecology, 82(5): 1205-1218.

