import sqlight
import wisp

// A Context type that holds any additional data that the
// request handlers need in addition to the request
// 
// Currently, only holds a database connection, but it could
// hold anything else such as API keys, IO performing functions, 
// config, etc
// 
pub type Context {
  Context(db: sqlight.Connection)
}

pub fn middleware(
  req: wisp.Request,
  handle_request: fn(wisp.Request) -> wisp.Response
) -> wisp.Response {
  let req = wisp.method_override(req)
  use <- wisp.log_request(req)
  use <- wisp.rescue_crashes
  use req <- wisp.handle_head(req)

  handle_request(req)
}
