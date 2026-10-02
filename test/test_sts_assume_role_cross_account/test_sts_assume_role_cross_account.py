import unittest
from pathlib import Path

from conftest import run_check

FIXTURES = Path(__file__).resolve().parent / "fixtures"
CHECK_ID = "GDS_DEVPLATFORM_003"


class TestSTSAssumeRoleCrossAccount(unittest.TestCase):
    def test_pass_principal_org_id(self):
        passed, failed = run_check(
            FIXTURES / "pass_trust_policy_principal_org_id.yaml", CHECK_ID
        )
        self.assertIn(CHECK_ID, passed)
        self.assertNotIn(CHECK_ID, failed)

    def test_pass_service_principal_not_applicable(self):
        passed, failed = run_check(FIXTURES / "pass_service_principal.yaml", CHECK_ID)
        self.assertIn(CHECK_ID, passed)
        self.assertNotIn(CHECK_ID, failed)

    def test_fail_no_principal_org_id(self):
        passed, failed = run_check(FIXTURES / "fail_no_principal_org_id.yaml", CHECK_ID)
        self.assertIn(CHECK_ID, failed)
        self.assertNotIn(CHECK_ID, passed)

    def test_fail_bare_root_no_org_id(self):
        passed, failed = run_check(FIXTURES / "fail_bare_root_no_org_id.yaml", CHECK_ID)
        self.assertIn(CHECK_ID, failed)
        self.assertNotIn(CHECK_ID, passed)


if __name__ == "__main__":
    unittest.main()
