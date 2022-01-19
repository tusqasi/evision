defmodule OpenCV.Test do
  use ExUnit.Case

  test "decode png from file w/o alpha channel" do
    ret =
      [__DIR__, "test.png"]
      |> Path.join
      |> OpenCV.imread()
    assert :ok == elem(ret, 0)
    mat = elem(ret, 1)

    ret = OpenCV.Mat.type(mat)
    assert :ok == elem(ret, 0)
    type = elem(ret, 1)
    assert {:u, 8} == type

    ret = OpenCV.Mat.shape(mat)
    assert :ok == elem(ret, 0)
    shape = elem(ret, 1)
    assert {2, 3, 3} == shape

    ret = OpenCV.Mat.to_binary(mat)
    assert :ok == elem(ret, 0)
    img_data = elem(ret, 1)

    assert <<126, 145, 241, 78, 190, 136, 183, 122, 68, 187, 196, 244, 145, 205, 190, 200,
              184, 144>> == img_data
  end

  test "decode png from file w/ alpha channel" do
    ret =
      [__DIR__, "test.png"]
      |> Path.join
      |> OpenCV.imread(flags: OpenCV.cv_imread_unchanged)
    assert :ok == elem(ret, 0)
    mat = elem(ret, 1)

    ret = OpenCV.Mat.type(mat)
    assert :ok == elem(ret, 0)
    type = elem(ret, 1)
    assert {:u, 8} == type

    ret = OpenCV.Mat.shape(mat)
    assert :ok == elem(ret, 0)
    shape = elem(ret, 1)
    assert {2, 3, 4} == shape

    ret = OpenCV.Mat.to_binary(mat)
    assert :ok == elem(ret, 0)
    img_data = elem(ret, 1)

    assert <<126, 145, 241, 255, 78, 190, 136, 255, 183, 122, 68, 255, 187, 196, 244, 255,
             145, 205, 190, 255, 200, 184, 144, 255>> == img_data
  end

  test "decode image from file grayscale" do
    ret =
      [__DIR__, "test.png"]
      |> Path.join
      |> OpenCV.imread(flags: OpenCV.cv_imread_grayscale)
    assert :ok == elem(ret, 0)
    mat = elem(ret, 1)

    ret = OpenCV.Mat.type(mat)
    assert :ok == elem(ret, 0)
    type = elem(ret, 1)
    assert {:u, 8} == type

    ret = OpenCV.Mat.shape(mat)
    assert :ok == elem(ret, 0)
    shape = elem(ret, 1)
    assert {2, 3} == shape

    ret = OpenCV.Mat.to_binary(mat)
    assert :ok == elem(ret, 0)
    img_data = elem(ret, 1)

    assert <<171, 161, 112, 209, 193, 173>> == img_data
  end

  test "decode jpg from file" do
    ret =
      [__DIR__, "test.jpg"]
      |> Path.join
      |> OpenCV.imread()
    assert :ok == elem(ret, 0)
    mat = elem(ret, 1)

    ret = OpenCV.Mat.type(mat)
    assert :ok == elem(ret, 0)
    type = elem(ret, 1)
    assert {:u, 8} == type

    ret = OpenCV.Mat.shape(mat)
    assert :ok == elem(ret, 0)
    shape = elem(ret, 1)
    assert {2, 3, 3} == shape

    ret = OpenCV.Mat.to_binary(mat)
    assert :ok == elem(ret, 0)
    img_data = elem(ret, 1)

    assert <<70, 128, 180, 61, 119, 171, 117, 143, 65, 112, 170, 222, 95, 153, 205, 140,
             166, 88>> == img_data
  end
end