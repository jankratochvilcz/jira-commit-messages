#! /bin/sh
# file: ../src/prepare-commit-msg.sh

test_message_file='fixtures/messages_test.txt'
target_message_file='test_runs/messages_test.txt'

execute_target='../src/prepare-commit-msg.sh'

setUp() {
    rm -r 'test_runs/'
    mkdir 'test_runs'
}

testWritesMessageIfNoJiraReference() {
    cp $test_message_file $target_message_file
    sh $execute_target $target_message_file

    actual=$(cat $target_message_file)

    assertEquals "hello" "$actual"
}

testIncludesJiraNumber() {
    branch_name='feature/xa-325'

    current_branch=$(git branch --show-current)
    git checkout -b $branch_name
    cp $test_message_file $target_message_file
    sh $execute_target $target_message_file

    actual=$(cat $target_message_file)

    assertEquals "[XA-325] hello" "$actual"

    git checkout $current_branch
    git branch -d $branch_name
}

# Load shUnit2.
. shunit2/shunit2