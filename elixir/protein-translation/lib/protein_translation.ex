defmodule ProteinTranslation do
  @mapping %{
    "UGU" => "Cysteine",
    "UGC" => "Cysteine",
    "UUA" => "Leucine",
    "UUG" => "Leucine",
    "AUG" => "Methionine",
    "UUU" => "Phenylalanine",
    "UUC" => "Phenylalanine",
    "UCU" => "Serine",
    "UCC" => "Serine",
    "UCA" => "Serine",
    "UCG" => "Serine",
    "UGG" => "Tryptophan",
    "UAU" => "Tyrosine",
    "UAC" => "Tyrosine",
    "UAA" => "STOP",
    "UAG" => "STOP",
    "UGA" => "STOP"
  }

  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: {atom, list(String.t())}
  def of_rna(rna) do
    codons = for <<x::binary-3 <- rna>>, do: x

    {statuses, proteins} =
      codons
      |> Enum.map(&of_codon/1)
      |> Enum.unzip()

    cond do
      :error in statuses -> {:error, "invalid RNA"}
      true -> {:ok, proteins |> trim_at_stop()}
    end
  end

  defp trim_at_stop([]), do: []
  defp trim_at_stop([h | _]) when h == "STOP", do: []
  defp trim_at_stop([h | t]), do: [h | trim_at_stop(t)]

  @doc """
  Given a codon, return the corresponding protein

  UGU -> Cysteine
  UGC -> Cysteine
  UUA -> Leucine
  UUG -> Leucine
  AUG -> Methionine
  UUU -> Phenylalanine
  UUC -> Phenylalanine
  UCU -> Serine
  UCC -> Serine
  UCA -> Serine
  UCG -> Serine
  UGG -> Tryptophan
  UAU -> Tyrosine
  UAC -> Tyrosine
  UAA -> STOP
  UAG -> STOP
  UGA -> STOP
  """
  @spec of_codon(String.t()) :: {atom, String.t()}
  def of_codon(codon) do
    case Map.fetch(@mapping, codon) do
      res = {:ok, _} -> res
      :error -> {:error, "invalid codon"}
    end
  end
end
