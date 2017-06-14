import lz4
import lz4._version
import lz4.block._block
import lz4.frame._frame

data = 100 * b"Hello World!"

compressed_data = lz4.block.compress(data)
print(len(data), len(compressed_data))
assert data == lz4.block.decompress(compressed_data)
