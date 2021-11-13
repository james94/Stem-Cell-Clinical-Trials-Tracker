import React from "react";
import axios from "axios";
import { PATIENTS_ALL_BASE_URL } from "../settings/";

class Example extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      query: "",
      data: [],
      filteredData: [],
    };
    this.handleInputChange = this.handleInputChange.bind(this);
  }

  handleInputChange = (event) => {
    const query = event.target.value;

    this.setState((prevState) => {
      const filteredData = prevState.data.filter((element) => {
        return element.p_username
          .toLowerCase()
          .includes(query.toString().toLowerCase());
      });
      return {
        query,
        filteredData,
      };
    });
  };

  getData = () => {
    axios
      .get(PATIENTS_ALL_BASE_URL)
      .then((response) => {
        const query = this.state;
        const filteredData = response.data.filter((element) => {
          return element.p_username
            .toLowerCase()
            .includes(query.toString().toLowerCase());
        });

        this.setState({
          data: response.data,
          filteredData,
        });
      })
      .catch((error) => {
        console.log(error);
      });
  };

  componentDidMount() {
    this.getData();
  }

  render() {
    let searchCode;
    if (this.state.query.length === 0) searchCode = <div></div>;
    else {
      searchCode = (
        <div className="card" style={{ width: "100%" }}>
          <ul className="list-group list-group-flush">
            {this.state.filteredData.map((i, key) => (
              <li
                //         style={{
                //           width: "100%",
                //           height: "42px",
                //           display: "flex",
                //           justifyContent: "center",
                //         }}
                key={key}
                className="list-group-item"
              >
                {i.p_username}
                <br /> Trial id: {i.trial_id}
                <br />
                Disease: {i.disease}
                <br /> Phase: {i.phase}
                <br /> Status: {i.p_status}
                <br /> Researcher id: {i.p_status}
              </li>
            ))}
          </ul>
        </div>
      );
    }
    return (
      <div className="container">
        <div className="row">
          <div className="col-sm-6 mx-auto">
            {/* <center> */}
            <h1
              className="my-4"
              style={{
                display: "flex",
                justifyContent: "center",
              }}
            >
              Search for all patients
            </h1>
            <form>
              <input
                style={{ width: "100%", height: "42px" }}
                placeholder="Enter patient username..."
                value={this.state.query}
                onChange={this.handleInputChange}
              />
              <i className="fas fa-search"></i>
              {searchCode}
            </form>
            {/* </center> */}
          </div>
        </div>
      </div>
    );
  }
}

export default Example;
