const base = "http://computech-management-system.herokuapp.com";
// const base = 'http://127.0.0.1:3000';

export const newBill = (bill) => {
  const token = document.querySelector("[name=csrf-token]").content;
  const response = fetch(`${base}/bills`, {
    headers: { "Content-Type": "application/json", "X-CSRF-TOKEN": token },
    method: "POST",
    body: JSON.stringify(bill),
  })
    .then((res) => res.json())
    .then((data) => data)
    .catch((err) => err);
  return response;
};
