 # lconnect
Simple tools to derive landscape connectivity metrics and prioritize habitat patches
based on their contribution to overall connectivity.

The objective of this package is to provide the simplest possible approach to derive 
landscape connectivity metrics.

# These are the landscape connectivity metrics currently provided:

##### Number of components #####
’NC’ - Number of components (groups of interconnected patches) in the landscape (Urban
and Keitt, 2001). Patches in the same component are considered to be accessible, 
while patches in different components are not. Highly connected landscapes have 
less components. Threshold dependent (dispersal distance).

##### Number of links #####
’LNK’ - Number of links connecting the patches. Considering that the maximum distance is
the species dispersal ability and that these graphs (landscapes) are binary, which 
means that the habitat patches are either connected or unconnected (Pascual-Hortal 
and Saura, 2006). Higher LNK implies higher connectivity. Threshold dependent 
(dispersal distance).

##### Size of the Largest Component #####
’SLC’ - Area of the largest component (group of interconnected patches) (Pascual-
Hortal and Saura, 2006). Threshold dependent (dispersal distance).

##### Mean Size of Components #####
’MSC’ - Mean component area (Pascual-Hortal and Saura, 2006). Threshold dependent 
(dispersal distance).

##### Class coincidence probability #####
’CCP’ - Class coincidence probability. It is defined as the probability that two 
randomly chosen points within the habitat belong to the same component. 
Ranges between 0 and 1 (Pascual-Hortal and Saura 2006). Higher CCP implies higher 
connectivity. Threshold dependent (dispersal distance).

##### Landscape coincidence probability #####
’LCP’ - Landscape coincidence probability. It is defined as the probability that 
two randomly chosen points in the landscape (whether in an habitat patch or not) 
belong to the same habitat component. Ranges between 0 and 1 (Pascual-Hortal and 
Saura 2006). Threshold dependent (dispersal distance).

##### Characteristic path length #####
’CPL’ - Characteristic path length. Mean of all the shortest paths between the 
network nodes (habitat patches) (Minor and Urban, 2008). The shorter the CPL 
value the more connected the patches are. Threshold dependent (dispersal distance).

##### Expected cluster size #####
’ECS’ - Expected cluster (component) size. Mean cluster size of the clusters weighted 
by area. (O’Brien et al.,2006 and Fall et al, 2007). This represents the size 
of the component in which a randomly located point in an habitat patch would reside. 
Although it is informative regarding the area of the component, it does not provide 
any ecologically meaningful information regarding the total area of habitat, 
as an example: ECS increases with less isolated small components or patches, 
although the total habitat decreases(Laita et al. 2011). Threshold dependent 
(dispersal distance).
 
##### Area-weighted flux #####
’AWF’ - Area-weighted Flux. Evaluates the flow, weighted by area, between all 
pairs of patches (Bunn et al. 2000 and Urban and Keitt 2001). The probability of 
dispersal between two patches (pij), required by the AWF formula, was computed 
using pij=exp(-k*dij), where k is a constant making pij=0.5 at half the dispersal 
distance defined by the user. Does not depend on any distance threshold (probabilistic).
 
##### Integral index of connectivity #####
’IIC’ - Integral index of connectivity. Index developed specifically for landscapes 
by Pascual-Hortal and Saura (2006). It is based on habitat availability and on a 
binary connection model (as opposed to a probabilistic). It ranges from 0 to 1 
(higher values indicating more connectivity). Threshold dependent (dispersal distance).

##### References #####
Bunn, A. G., Urban, D. L., and Keitt, T. H. (2000). Landscape connectivity: a 
conservation application of graph theory. Journal of Environmental Management, 
59(4): 265-278.

Fall, A., Fortin, M. J., Manseau, M., and O’ Brien, D. (2007). Spatial graphs: 
principles and applications for habitat connectivity. Ecosystems, 10(3): 448-461.

Laita, A., Kotiaho, J.S., Monkkonen, M. (2011). Graph-theoretic connectivity 
measures: what do they tell us about connectivity? Landscape Ecology, 26: 951-967.

Minor, E. S., and Urban, D. L. (2008). A Graph-Theory Framework for Evaluating 
Landscape Connectivity and Conservation Planning. Conservation Biology, 22(2): 297-307.

O’Brien, D., Manseau, M., Fall, A., and Fortin, M. J. (2006). Testing the importance 
of spatial configuration of winter habitat for woodland caribou: an application of 
graph theory. Biological Conservation, 130(1): 70-83.

Pascual-Hortal, L., and Saura, S. (2006). Comparison and development of new 
graph-based landscape connectivity indices: towards the priorization of habitat 
patches and corridors for conservation. Landscape Ecology, 21(7): 959-967.

Urban, D., and Keitt, T. (2001). Landscape connectivity: a graph-theoretic 
perspective. Ecology, 82(5): 1205-1218.

