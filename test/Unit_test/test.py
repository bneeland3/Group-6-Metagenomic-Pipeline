import sys  # import sys
sys.path.insert(0, '../../src')  # noqa #set up a path using sys
import unittest
import fire_gdp
import random

#Need to fix up this file

class Snakemake(unittest.TestCase):
    def test_search(self):
        self.assertEqual(fire_gdp.search([1, 2, 3, 4, 5], 3), 2)
        self.assertEqual(fire_gdp.search([], 5), None)
        self.assertEqual(fire_gdp.search([1, 2, 3, 4, 5, 6, 7, 9],
                                         10000), None)
       