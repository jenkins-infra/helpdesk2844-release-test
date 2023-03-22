#!/usr/bin/env bats

load release

function testGuessGitBranchInformation {
  
  BRANCH_NAME=$1
  EXPECTED_RELEASE_PROFILE=$2
  EXPECTED_RELEASELINE=$3
  EXPECTED_JENKINS_VERSION=$4

  # release.bash will only guess informations if the three following variables are unset
  unset RELEASE_PROFILE
  unset RELEASELINE
  unset JENKINS_VERSION

  guessGitBranchInformation 

  @test "Guess RELEASE_PROFILE based on branch $BRANCH_NAME" {
    echo "EXPECTED RELEASE_PROFILE = $EXPECTED_RELEASE_PROFILE"
    echo "GOT RELEASE_PROFILE = $RELEASE_PROFILE"
    [ "$RELEASE_PROFILE" = "$EXPECTED_RELEASE_PROFILE" ]
  }

  @test "Guess RELEASELINE based on branch $BRANCH_NAME" {
    echo "EXPECTED RELEASELINE: $EXPECTED_RELEASELINE"
    echo "GOT RELEASELINE = $RELEASELINE"
    [ "$RELEASELINE" = "$EXPECTED_RELEASELINE" ]
  }

  @test "Guess JENKINS_VERSION for branch $BRANCH_NAME" {
    echo "EXPECTED JENKINS_VERSION = $EXPECTED_JENKINS_VERSION"
    echo "GOT JENKINS_VERSION = $JENKINS_VERSION"
    [ "$JENKINS_VERSION" = "$EXPECTED_JENKINS_VERSION" ]
  }
}

testGuessGitBranchInformation "stable-2.235" "stable" "-stable" "2.235"
testGuessGitBranchInformation "master" "weekly" "" "latest"
testGuessGitBranchInformation "security-stable-2.235" "security" "-stable" "2.235"
# Following test is commented out as I am not sure what the branch format should look like
#testGuessGitBranchInformation "security-2.235" "security" "" "latest"
