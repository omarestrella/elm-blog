exports.handler = function (event, context) {
  return {
    status: 200,
    body: JSON.stringify({
      posts: [],
    }),
  };
};
