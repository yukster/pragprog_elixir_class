defmodule DictionaryTest do
  use ExUnit.Case
  doctest Dictionary

  test "random_word picks random word from list" do
    assert String.length(Dictionary.random_word) > 1
  end
end
