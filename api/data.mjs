import faker from "faker";

const ids = [1, 2, 3, 4, 5, 6].map((id) => id.toString());

export const posts = ids.map((id) => {
  return {
    id,
    title: faker.lorem.words(faker.random.number(6) + 4),
    body: faker.lorem.paragraphs(faker.random.number(4) + 3, "\n"),
  };
});

export const comments = ids.reduce((list, postId) => {
  return list.concat(
    [...new Array(faker.random.number(2) + 2)].map(() => {
      return {
        id: faker.random.uuid(),
        postId,
        name: `${faker.name.firstName()} ${faker.name.lastName()}`,
        body: faker.lorem.paragraph(faker.random.number(8) + 4),
      };
    })
  );
}, []);
