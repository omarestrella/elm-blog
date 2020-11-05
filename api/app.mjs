import r from "koa-route";
import Koa from "koa";
import { posts, comments } from "./data.mjs";

function wait(time = 500) {
  return new Promise((resolve) => setTimeout(resolve, time));
}

const app = new Koa();

app.use(
  r.get("/posts", function (ctx) {
    ctx.body = {
      posts: posts,
    };
  })
);

app.use(
  r.get("/posts/:id", async function (ctx, id) {
    await wait(1000);

    let post = posts.find((p) => p.id === id);
    if (!post) {
      ctx.res.statusCode = 404;
      return;
    }
    ctx.body = {
      post: posts.find((p) => p.id === id),
    };
  })
);

app.use(
  r.get("/posts/:id/comments", function (ctx, id) {
    ctx.body = {
      comments: comments.filter((comment) => comment.postId === id),
    };
  })
);

app.use(async (ctx, next) => {
  ctx.res.setHeader("Content-Type", "application/json");
  if (typeof ctx.body === "object") {
    ctx.body = JSON.stringify(ctx.body);
  }
  console.log(ctx);
  next();
});

app.listen(3000);
