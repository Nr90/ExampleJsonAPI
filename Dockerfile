FROM julia:1

WORKDIR /root/ExampleJsonAPI
ADD Project.toml /root/ExampleJsonAPI/
ADD Manifest.toml /root/ExampleJsonAPI/
RUN julia -e "using Pkg; Pkg.activate(\".\"); Pkg.instantiate()"
ADD run.jl /root/ExampleJsonAPI/
ADD src /root/ExampleJsonAPI/src/

CMD ["julia", "run.jl"]