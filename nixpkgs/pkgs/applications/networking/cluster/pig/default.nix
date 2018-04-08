{ stdenv, fetchurl, makeWrapper, hadoop, jre, bash }:

stdenv.mkDerivation rec {

  name = "pig-0.16.0";

  src = fetchurl {
    url = "mirror://apache/pig/${name}/${name}.tar.gz";
    sha256 = "0p79grz5islnq195lv7pqdxb5l3v4y0k0w63602827qs70zpr508";

  };

  buildInputs = [ makeWrapper ];

  installPhase = ''
    mkdir -p $out
    mv * $out

    # no need for the windows batch script
    rm $out/bin/pig.cmd $out/bin/pig.py

    for n in $out/{bin,sbin}"/"*; do
      wrapProgram $n \
        --prefix PATH : "${stdenv.lib.makeBinPath [ jre bash ]}" \
        --set JAVA_HOME "${jre}" --set HADOOP_PREFIX "${hadoop}"
    done
  '';

  meta = with stdenv.lib; {
    homepage = http://pig.apache.org/;
    description = "High-level language for Apache Hadoop";
    license = licenses.asl20;

    longDescription = ''
      Apache Pig is a platform for analyzing large data sets that consists of a
      high-level language for expressing data analysis programs, coupled with
      infrastructure for evaluating these programs. The salient property of Pig
      programs is that their structure is amenable to substantial parallelization,
      which in turns enables them to handle very large data sets.
    '';

    platforms = platforms.linux;
    maintainers = [ maintainers.skeidel ];
  };
}
