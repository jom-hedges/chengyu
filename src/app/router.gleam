import app/web.{type Context}
import app/web/chengyu
import wisp.{type Request, type Response}

pub fn handle_request(req: Request, ctx: Context) -> Response {
  use req <- web.middleware(req)
  
  // The 'app/web/chengyu' module deals contains the handlers and other functions
  // that relate to the Chengyu feature of the app 
  //
  // The router module only deals with routing, and dispatches to
  // the feature modules for handling requests
  case wisp.path_segments(req) {
    ["chengyu"] -> chengyu.all(req, ctx)
    ["chengyu", id] -> chengyu.one(req, ctx, id)
    _ -> wisp.not_found()
  }
}
