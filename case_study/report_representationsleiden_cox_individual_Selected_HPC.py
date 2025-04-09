# Imports
import argparse
import os

# Own libs.
from models.clustering.logistic_regression_leiden_clusters import run_circular_plots
from models.clustering.cox_proportional_hazard_regression_leiden_clusters import *

##### Main #######
parser = argparse.ArgumentParser(description='Report classification and cluster performance based on Logistic Regression.')
parser.add_argument('--alpha',               dest='alpha',               type=float,          default=None,        help='Cox regression penalty value.')
parser.add_argument('--resolution',          dest='resolution',          type=float,          default=1.0,         help='Leiden resolution.')
parser.add_argument('--meta_folder',         dest='meta_folder',         type=str,            default=None,        help='Purpose of the clustering, name of folder.')
parser.add_argument('--matching_field',      dest='matching_field',      type=str,            default=None,        help='Key used to match folds split and H5 representation file.')
parser.add_argument('--event_ind_field',     dest='event_ind_field',     type=str,            default=None,        help='Key used to match event indicator field.')
parser.add_argument('--event_data_field',    dest='event_data_field',    type=str,            default=None,        help='Key used to match event data field.')
parser.add_argument('--diversity_key',       dest='diversity_key',       type=str,            default=None,        help='Key use to check diversity within cluster: Slide, Institution, Sample.')
parser.add_argument('--type_composition',    dest='type_composition',    type=str,            default='clr',       help='Space transformation type: percent, clr, ilr, alr.')
parser.add_argument('--l1_ratio',            dest='l1_ratio',            type=float,          default=0.0,         help='L1 Penalty for Cox regression.')
parser.add_argument('--min_tiles',           dest='min_tiles',           type=int,            default=100,         help='Minimum number of tiles per matching_field.')
parser.add_argument('--force_fold',          dest='force_fold',          type=int,            default=None,        help='Force fold of clustering.')
parser.add_argument('--folds_pickle',        dest='folds_pickle',        type=str,            default=None,        help='Pickle file with folds information.')
parser.add_argument('--h5_complete_path',    dest='h5_complete_path',    type=str,            required=True,       help='H5 file path to run the leiden clustering folds.')
parser.add_argument('--h5_additional_path',  dest='h5_additional_path',  type=str,            default=None,        help='Additional H5 representation to assign leiden clusters.')
parser.add_argument('--additional_as_fold',  dest='additional_as_fold',  action='store_true', default=False,       help='Flag to specify if additional H5 file will be used for cross-validation.')
parser.add_argument('--remove_clusters_type',     dest='remove_clusters_type',     type=str,            default=None,        help='type of run for cluster removal hard-coded below.')
args               = parser.parse_args()
alpha              = args.alpha
resolution         = args.resolution
meta_folder        = args.meta_folder
matching_field      = args.matching_field
event_ind_field     = args.event_ind_field
event_data_field    = args.event_data_field
diversity_key      = args.diversity_key
type_composition   = args.type_composition
min_tiles          = args.min_tiles
l1_ratio           = args.l1_ratio
folds_pickle       = args.folds_pickle
force_fold         = args.force_fold
h5_complete_path   = args.h5_complete_path
h5_additional_path = args.h5_additional_path
additional_as_fold = args.additional_as_fold

# Other features
q_buckets  = 2
max_months = 12.0*6.0

# anti-CTLA4 according to non-statistically significant on train set
if args.remove_clusters_type == None:
	remove_clusters = None
elif args.remove_clusters_type == 'anti-CTLA4':
	remove_clusters = [0, 1, 4,5, 7,8, 11,12 ,15,16, 18, 21,22,28,32,34, 36,38,39,42,43,45,47,50,51, 9, 10, 17,19,20,27,35,41,44]
elif args.remove_clusters_type == 'anti-PD1':
	remove_clusters = [1,2,3, 5,7,9,10,13,15,16,17,19,21,22,25,27,28,30,32,34,35,37,39,40,41,42,44,45,46,50,51, 4,6,8,11,12,14,20,23,26,29,33,36,43,47,48,49]
elif args.remove_clusters_type == 'both':
	remove_clusters = [0, 1, 2,3 ,4,5,8,9,10,11,12,13,14,15,16,17,18,19,21,22,23,24,25,26,27,28,30,31,32,35,38,40,41,42,43,44,46,47,48,50,51]
elif args.remove_clusters_type == 'allT':
        remove_clusters = [0, 1, 5, 7, 8, 10, 11, 13, 15, 16, 17, 21, 22, 27, 28, 30, 32, 34, 35, 36, 38, 39, 42, 43, 45, 47, 48, 49, 51]
elif args.remove_clusters_type == 'None':
	remove_clusters = None

# Run Cox Proportional Hazard Regression with L1/L2 Penalties.
run_cph_regression_individual(alpha, resolution, meta_folder, matching_field, folds_pickle, event_ind_field, event_data_field, h5_complete_path, h5_additional_path, diversity_key, type_composition,
							  min_tiles, max_months, additional_as_fold, force_fold, l1_ratio, q_buckets=q_buckets, use_conn=False, use_ratio=False, top_variance_feat=0, remove_clusters=remove_clusters,
							  p_th=0.05)

