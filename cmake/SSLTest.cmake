set(FILE_NAME "LICENSE")
set(DOWNLOAD_URL "https://raw.githubusercontent.com/conda-forge/cmake-feedstock/master/${FILE_NAME}")
set(EXPECTED_SHA256 "f8c925402b90f74566f71e64eea7bb9d83daac69cde71408ffd6c043be6a4991")

file(DOWNLOAD ${DOWNLOAD_URL} ${CMAKE_CURRENT_BINARY_DIR}/${FILE_NAME}
 SHOW_PROGRESS
 EXPECTED_HASH  SHA256=${EXPECTED_SHA256}
 STATUS STATUS
 TLS_VERIFY on )

list( GET STATUS 0 RET )
list( GET STATUS 1 MESSAGE )

if( NOT RET EQUAL 0 )
  message(FATAL "Error Downloading file: ${MESSAGE}")
endif()
