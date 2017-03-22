import lz4

data = 100 * b"Hello World!"

compressed_data = lz4.block.compress(data)
print(len(data), len(compressed_data))
assert data == lz4.block.decompress(compressed_data)
