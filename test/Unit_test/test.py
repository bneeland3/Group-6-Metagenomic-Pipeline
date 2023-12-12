import unittest

def read_sample_names(filename):
    with open(filename, 'r') as file:
        return [line.strip().split('.')[0].split('_')[0] for line in file]

class TestReadSampleNames(unittest.TestCase):
    def test_read_sample_names(self):
        # Prepare a test sample_names.txt file with some sample names
        with open("sample_names.txt", "w") as file:
            file.write("sample1_file.fastq\nsample2_file.fastq\nsample3_file.fastq")

        # Test if read_sample_names function extracts sample names correctly
        samples = read_sample_names("sample_names.txt")
        self.assertEqual(samples, ["sample1", "sample2", "sample3"])

if __name__ == "__main__":
    unittest.main()
       
