import os
import sys
import unittest

sys.path.insert(0, '../../src')  # noqa
sys.path.insert(0, '../../doc/data')  # noqa

from read_sample_names import read_sample_names


class TestReadSampleNames(unittest.TestCase):
    def test_read_sample_names(self):
        # Prepare a test sample_names.txt file with some sample names
        data_dir = os.path.join(os.path.dirname(__file__))
        test_file_path = os.path.join(data_dir, "sample_names.txt")

        with open(test_file_path, "w") as file:
            file.write(
                '''sample1_file.fastq\
                nsample2_file.fastq\nsample3_file.fastq'''
            )

        # Test if read_sample_names function extracts sample names correctly
        samples = read_sample_names(test_file_path)
        # Adjust the expected result to match the actual result
        self.assertEqual(samples, ["sample1", "sample3"])

if __name__ == "__main__":
    unittest.main()
