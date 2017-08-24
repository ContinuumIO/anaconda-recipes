import sklearn

print("sklearn.__version__: %s" % sklearn.__version__)
assert sklearn.__version__ == '0.19.0'

import sklearn.__check_build._check_build
import sklearn._isotonic
import sklearn.cluster._dbscan_inner
import sklearn.cluster._hierarchical
import sklearn.cluster._k_means
import sklearn.cluster._k_means_elkan
import sklearn.datasets._svmlight_format
import sklearn.decomposition._online_lda
import sklearn.decomposition.cdnmf_fast
import sklearn.ensemble._gradient_boosting
import sklearn.feature_extraction._hashing
import sklearn.linear_model.cd_fast
import sklearn.linear_model.sag_fast
import sklearn.linear_model.sgd_fast
import sklearn.manifold._barnes_hut_tsne
import sklearn.manifold._utils
import sklearn.metrics.cluster.expected_mutual_info_fast
import sklearn.metrics.pairwise_fast
import sklearn.neighbors.ball_tree
import sklearn.neighbors.dist_metrics
import sklearn.neighbors.kd_tree
import sklearn.neighbors.quad_tree
import sklearn.neighbors.typedefs
import sklearn.svm.liblinear
import sklearn.svm.libsvm
import sklearn.svm.libsvm_sparse
import sklearn.tree._criterion
import sklearn.tree._splitter
import sklearn.tree._tree
import sklearn.tree._utils
import sklearn.utils._logistic_sigmoid
import sklearn.utils._random
import sklearn.utils.arrayfuncs
import sklearn.utils.fast_dict
import sklearn.utils.graph_shortest_path
import sklearn.utils.lgamma
import sklearn.utils.murmurhash
import sklearn.utils.seq_dataset
import sklearn.utils.sparsefuncs_fast
import sklearn.utils.weight_vector

from cio_bt.mkl_link import test_modules
test_modules([
    sklearn.linear_model.cd_fast,
    sklearn.svm.liblinear,
    sklearn.utils.arrayfuncs,
])
