require "application_system_test_case"

class CollaboratorsTest < ApplicationSystemTestCase
  setup do
    @collaborator = collaborators(:one)
  end

  test "visiting the index" do
    visit collaborators_url
    assert_selector "h1", text: "Collaborators"
  end

  test "creating a Collaborator" do
    visit collaborators_url
    click_on "New Collaborator"

    fill_in "Board", with: @collaborator.board_id
    fill_in "User", with: @collaborator.user_id
    click_on "Create Collaborator"

    assert_text "Collaborator was successfully created"
    click_on "Back"
  end

  test "updating a Collaborator" do
    visit collaborators_url
    click_on "Edit", match: :first

    fill_in "Board", with: @collaborator.board_id
    fill_in "User", with: @collaborator.user_id
    click_on "Update Collaborator"

    assert_text "Collaborator was successfully updated"
    click_on "Back"
  end

  test "destroying a Collaborator" do
    visit collaborators_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Collaborator was successfully destroyed"
  end
end
