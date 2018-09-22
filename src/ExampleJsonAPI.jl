module ExampleJsonAPI
export run
using HTTP
using Sockets
using JSON

function json_response(handler::Function)
    function jsonify(request)
        d, status = handler(request)
        resp = HTTP.Response(status, json(d))
        HTTP.setheader(resp, "content-type" => "application/json")
        resp
    end
    jsonify
end


function handler(request::HTTP.Messages.Request)
    Dict("Hello" => "World!"), 200
end


const router = Ref{HTTP.Router}()

function run()
    router[] = HTTP.Router()
    HTTP.register!(router[], "GET", "/", HTTP.HandlerFunction(json_response(handler)))
    HTTP.listen(ip"0.0.0.0", 8000) do http
        HTTP.handle(router[], http)
    end
end

end # module
