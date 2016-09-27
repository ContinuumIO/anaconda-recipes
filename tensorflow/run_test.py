import tensorflow as tf
hello = tf.constant('Hello, TensorFlow!')
sess = tf.Session()
out = sess.run(hello)
a = tf.constant(10)
b = tf.constant(32)
sess.run(a+b)
